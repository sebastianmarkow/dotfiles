-- Caffeinate replacement menubar
local Caffeinate = {
  menubar = hs.menubar.new(),
  batteryCap = 10.0,
  style = {
    strokeWidth = 0,
    strokeColor = { white = 1, alpha = 0 },
    fillColor = { white = 0, alpha = 0.25 },
    textColor = { white = 1, alpha = 1 },
    textFont = '.AppleSystemUIFont',
    textSize = 27,
    radius = 15,
    atScreenEdge = 0,
    fadeInDuration = 0.15,
    fadeOutDuration = 0.15,
    padding = nil,
  },
  activityIntervalSeconds = 25, -- seconds between idle-activity checks
  activityTimer = nil, -- Timer to be controlled based on state
  wiggleInProgress = false,
  activityDurationMS = 3100,
  activityMouseMoveRangePixel = 200,
  lastUserActivityID = 0,
  activeMeetingCount = 0,
  caffeinateWasActive = false,
  zoomMeetingWindows = {},
  teamsMeetingWindows = {},
  slackMeetingWindows = {},
}

function Caffeinate:setIcon(state)
  if state then
    self.menubar:setIcon(hs.configdir .. '/assets/caffeinate_active.pdf')
  else
    self.menubar:setIcon(hs.configdir .. '/assets/caffeinate_inactive.pdf')
  end
end

function Caffeinate:toggle(silent)
  local state = hs.caffeinate.toggle('displayIdle')
  self:setIcon(state)

  if state then
    if not self.activityTimer then
      self.activityTimer = hs.timer.doEvery(self.activityIntervalSeconds, function()
        self:mouseWiggler()
      end)
    end
  else
    if self.activityTimer then
      self.activityTimer:stop()
      self.activityTimer = nil
    end
  end
  if not silent then
    if state then
      hs.alert.show('Caffeinate on', self.style, nil, 1)
    else
      hs.alert.show('Caffeinate off', self.style, nil, 1)
    end
  end
end

function Caffeinate:mouseWiggler()
  local idleTime = hs.host.idleTime()
  if self.wiggleInProgress then return end

  if idleTime >= self.activityIntervalSeconds then
    self.wiggleInProgress = true
    local originalPos = hs.mouse.absolutePosition()
    local totalSteps = math.floor(self.activityDurationMS / 100)

    local step
    step = function(n)
      if n <= totalSteps then
        hs.mouse.absolutePosition({
          x = originalPos.x + math.random(-self.activityMouseMoveRangePixel, self.activityMouseMoveRangePixel),
          y = originalPos.y + math.random(-self.activityMouseMoveRangePixel, self.activityMouseMoveRangePixel),
        })
        hs.timer.doAfter(0.1, function() step(n + 1) end)
      else
        -- Return the mouse to its original position after wiggling
        hs.mouse.absolutePosition(originalPos)
        hs.eventtap.leftClick(hs.mouse.absolutePosition())
        hs.timer.usleep(10000) -- 10ms delay
        hs.eventtap.rightClick(hs.mouse.absolutePosition())
        hs.timer.usleep(10000) -- 10ms delay
        hs.eventtap.leftClick(hs.mouse.absolutePosition())
        self.lastUserActivityID = hs.caffeinate.declareUserActivity(self.lastUserActivityID)
        self.wiggleInProgress = false
      end
    end

    step(1)
  end
end

function Caffeinate:onMeetingStart()
  self.activeMeetingCount = self.activeMeetingCount + 1
  if self.activeMeetingCount == 1 then
    if hs.caffeinate.get('displayIdle') then
      self.caffeinateWasActive = true
      self:toggle(true)
      hs.notify.show('Caffeinate', '', 'Paused for active call')
    end
  end
end

function Caffeinate:onMeetingEnd()
  self.activeMeetingCount = math.max(0, self.activeMeetingCount - 1)
  if self.activeMeetingCount == 0 and self.caffeinateWasActive then
    self.caffeinateWasActive = false
    if not hs.caffeinate.get('displayIdle') then
      self:toggle(true)
      hs.notify.show('Caffeinate', '', 'Resumed after call ended')
    end
  end
end

function Caffeinate:batteryCallback()
  if hs.battery.powerSource() == 'Battery Power' then
    if hs.battery.percentage() <= self.batteryCap and hs.caffeinate.get('displayIdle') then
      self:toggle()
      hs.notify.show('Caffeinate disabled', '', 'Battery power below ' .. self.batteryCap .. '%')
    end
  end
end

if Caffeinate.menubar then
  Caffeinate.menubar:setTooltip('Toggle Caffeinate')
  Caffeinate.menubar:setClickCallback(function()
    Caffeinate:toggle()
  end)
  Caffeinate:setIcon(hs.caffeinate.get('displayIdle'))
  hs.battery.watcher
    .new(function()
      Caffeinate:batteryCallback()
    end)
    :start()
  hs.hotkey.bind(hs.settings.get('leader'), 'c', function()
    Caffeinate:toggle()
  end)

  -- Zoom: a dedicated 'Zoom Meeting' window appears for the duration of a call.
  -- Subscribe to windowCreated and re-check after a short delay because Zoom sets
  -- the title asynchronously after window creation; deduplication is done by window ID.
  local zoomWF = hs.window.filter.new(false):setAppFilter('zoom.us')
  zoomWF:subscribe(hs.window.filter.windowCreated, function(win)
    local function checkZoomWindow(w)
      if not w or not w:isStandard() then return end
      local t = w:title()
      if (t == 'Zoom Meeting' or t == 'Zoom Webinar') and not Caffeinate.zoomMeetingWindows[w:id()] then
        Caffeinate.zoomMeetingWindows[w:id()] = true
        Caffeinate:onMeetingStart()
      end
    end
    checkZoomWindow(win)
    -- Zoom sometimes sets the window title asynchronously after creation;
    -- re-check after a short delay to catch the title change.
    hs.timer.doAfter(1.5, function() checkZoomWindow(win) end)
  end)
  zoomWF:subscribe(hs.window.filter.windowDestroyed, function(win)
    if Caffeinate.zoomMeetingWindows[win:id()] then
      Caffeinate.zoomMeetingWindows[win:id()] = nil
      Caffeinate:onMeetingEnd()
    end
  end)

  -- Fallback: if Zoom crashes or quits mid-call, drain all tracked Zoom meetings.
  Caffeinate.zoomAppWatcher = hs.application.watcher.new(function(name, event, app)
    if name == 'zoom.us' and event == hs.application.watcher.terminated then
      local count = 0
      for _ in pairs(Caffeinate.zoomMeetingWindows) do count = count + 1 end
      Caffeinate.zoomMeetingWindows = {}
      for _ = 1, count do
        Caffeinate:onMeetingEnd()
      end
    end
  end):start()

  -- Teams: call windows have dynamic titles (meeting/channel name);
  -- any window that isn't the main app shell is treated as a call.
  -- A minimum title length of 10 filters out short transient windows.
  -- Verify with: hs.application.get('Microsoft Teams'):allWindows()
  local teamsWF = hs.window.filter.new(false):setAppFilter('Microsoft Teams')
  teamsWF:subscribe(hs.window.filter.windowCreated, function(win)
    local t = win:title()
    if t ~= '' and t:len() > 10 and not t:match('^Microsoft Teams') and not Caffeinate.teamsMeetingWindows[win:id()] then
      Caffeinate.teamsMeetingWindows[win:id()] = true
      Caffeinate:onMeetingStart()
    end
  end)
  teamsWF:subscribe(hs.window.filter.windowDestroyed, function(win)
    if Caffeinate.teamsMeetingWindows[win:id()] then
      Caffeinate.teamsMeetingWindows[win:id()] = nil
      Caffeinate:onMeetingEnd()
    end
  end)

  -- Slack: huddles open a floating window separate from the main app.
  -- Verify title with: hs.application.get('Slack'):allWindows()
  local slackWF = hs.window.filter.new(false):setAppFilter('Slack')
  slackWF:subscribe(hs.window.filter.windowCreated, function(win)
    local t = win:title()
    if (t == 'Huddle' or t == 'Slack Call') and not Caffeinate.slackMeetingWindows[win:id()] then
      Caffeinate.slackMeetingWindows[win:id()] = true
      Caffeinate:onMeetingStart()
    end
  end)
  slackWF:subscribe(hs.window.filter.windowDestroyed, function(win)
    if Caffeinate.slackMeetingWindows[win:id()] then
      Caffeinate.slackMeetingWindows[win:id()] = nil
      Caffeinate:onMeetingEnd()
    end
  end)
end
