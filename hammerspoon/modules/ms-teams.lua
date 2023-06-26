local log = hs.logger.new('teams', 'debug')

-- Mute Button
function toggleMute() 
  local teams = hs.application.find("com.microsoft.teams")
  if not (teams == null) then
    log.i("mute teams")
    hs.eventtap.keyStroke({"cmd","shift"}, "m", 0, teams)
  end
end

-- Video Button
function toggleVideo() 
  local teams = hs.application.find("com.microsoft.teams")
  if not (teams == null) then
    log.i("mute teams")
    hs.eventtap.keyStroke({"cmd","shift"}, "o", 0, teams)
  end
end

local modifiers = {"ctrl", "shift"}
hs.hotkey.bind(modifiers, "7", toggleMute)
local modifiers = {"ctrl", "shift"}
hs.hotkey.bind(modifiers, "8", toggleVideo)
