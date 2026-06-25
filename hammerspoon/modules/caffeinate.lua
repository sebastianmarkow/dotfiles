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
  activityDurationMS = 1000,
  activityMouseMoveRangePixel = 50,
  lastUserActivityID = 0,
  activeMeetingCount = 0,
  caffeinateWasActive = false,
  inCall = false,
  cameras = {},
  inputDevices = {},
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
      self.activityTimer = hs.timer.doEvery(self.activityIntervalSeconds, function() self:mouseWiggler() end)
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
  if self.wiggleInProgress then return end
  if hs.host.idleTime() < self.activityIntervalSeconds then return end

  self.wiggleInProgress = true
  local originalPos = hs.mouse.absolutePosition()
  local frameInterval = 0.015 -- 15ms per frame (~60fps)
  local totalSteps = math.max(1, math.floor(self.activityDurationMS / (frameInterval * 1000)))
  local range = self.activityMouseMoveRangePixel

  local step
  step = function(i)
    if i <= totalSteps then
      local t = i / totalSteps
      local offset = math.sin(math.pi * t) * range
      hs.mouse.absolutePosition({ x = originalPos.x + offset, y = originalPos.y })
      hs.timer.doAfter(frameInterval, function() step(i + 1) end)
    else
      hs.mouse.absolutePosition(originalPos)
      local ok, activityID = pcall(function()
        hs.eventtap.leftClick(originalPos)
        return hs.caffeinate.declareUserActivity(self.lastUserActivityID)
      end)
      if ok then self.lastUserActivityID = activityID end
      self.wiggleInProgress = false
    end
  end

  step(1)
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

function Caffeinate:isOnCall()
  for _, camera in ipairs(hs.camera.allCameras()) do
    if camera:isInUse() then return true end
  end
  for _, device in ipairs(hs.audiodevice.allInputDevices()) do
    if device:inUse() then return true end
  end
  return false
end

function Caffeinate:evaluateCallState()
  local onCall = self:isOnCall()
  if onCall and not self.inCall then
    self.inCall = true
    self:onMeetingStart()
  elseif not onCall and self.inCall then
    self.inCall = false
    self:onMeetingEnd()
  end
end

function Caffeinate:attachCameraWatchers()
  local cameras = hs.camera.allCameras()
  if #cameras == 0 and self.inCall then return end
  self.cameras = cameras
  for _, camera in ipairs(self.cameras) do
    if not camera:isPropertyWatcherRunning() then
      camera
        :setPropertyWatcherCallback(function(_cam, prop, _scope, _element)
          if prop == 'gone' then self:evaluateCallState() end
        end)
        :startPropertyWatcher()
    end
  end
end

function Caffeinate:attachAudioWatchers()
  self.inputDevices = hs.audiodevice.allInputDevices()
  for _, device in ipairs(self.inputDevices) do
    if not device:watcherIsRunning() then
      device:watcherCallback(function(_uid, eventName, _scope, _element)
        if eventName == 'gone' then self:evaluateCallState() end
      end)
      device:watcherStart()
    end
  end
end

if Caffeinate.menubar then
  Caffeinate.menubar:setTooltip('Toggle Caffeinate')
  Caffeinate.menubar:setClickCallback(function() Caffeinate:toggle() end)
  Caffeinate:setIcon(hs.caffeinate.get('displayIdle'))
  hs.battery.watcher.new(function() Caffeinate:batteryCallback() end):start()
  hs.hotkey.bind(hs.settings.get('leader'), 'c', function() Caffeinate:toggle() end)

  -- Camera + microphone in-use watcher: replaces per-app window filters.
  -- Covers Zoom, Microsoft Teams, Slack huddles, and any other app that uses camera/mic.
  Caffeinate:attachCameraWatchers()
  hs.camera.setWatcherCallback(function(_cam, _event)
    Caffeinate:attachCameraWatchers()
    Caffeinate:evaluateCallState()
  end)
  hs.camera.startWatcher()

  -- Audio input device watchers: fire evaluateCallState on in-use state changes.
  Caffeinate:attachAudioWatchers()
  hs.audiodevice.watcher.setCallback(function()
    Caffeinate:attachAudioWatchers()
    Caffeinate:evaluateCallState()
  end)
  hs.audiodevice.watcher.start()
end
