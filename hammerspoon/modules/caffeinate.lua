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
  activityIntervalSeconds = 25, -- 1 minutes in seconds
  activityTimer = nil, -- Timer to be controlled based on state
  activityDurationMS = 3100,
  activityMouseMoveRangePixel = 200,
  lastUserActivityID = 0,
}

function Caffeinate:setIcon(state)
  if state then
    self.menubar:setIcon('./assets/caffeinate_active.pdf')
  else
    self.menubar:setIcon('./assets/caffeinate_inactive.pdf')
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

  -- If the system has been idle for more than 2 minutes (120 seconds)
  if idleTime >= self.activityIntervalSeconds then
    local currentMousePosition = hs.mouse.absolutePosition()

    -- Wiggle for 1000ms
    local endTime = hs.timer.absoluteTime() + 1000000000 -- 1s in nanoseconds
    while hs.timer.absoluteTime() < endTime do
      -- Generate random wiggle within a small range
      local wiggleDistanceX = math.random(-self.activityMouseMoveRangePixel, self.activityMouseMoveRangePixel)
      local wiggleDistanceY = math.random(-self.activityMouseMoveRangePixel, self.activityMouseMoveRangePixel)

      -- Move the mouse to the new random position
      hs.mouse.setRelativePosition({
        x = currentMousePosition.x + wiggleDistanceX,
        y = currentMousePosition.y + wiggleDistanceY,
      })

      -- Small delay to allow the wiggle effect to take place
      hs.timer.usleep(10000) -- 10ms delay
    end

    -- Return the mouse to its original position after wiggling
    hs.mouse.setRelativePosition(currentMousePosition)
    hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())
    hs.timer.usleep(10000) -- 10ms delay
    hs.eventtap.rightClick(hs.mouse.getAbsolutePosition())
    hs.timer.usleep(10000) -- 10ms delay
    hs.eventtap.leftClick(hs.mouse.getAbsolutePosition())

    self.lastUserActivityID = hs.caffeinate.declareUserActivity(self.lastUserActivityID)
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

if Caffeinate then
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
end
