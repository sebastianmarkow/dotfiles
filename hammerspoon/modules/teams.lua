-- Mute Button
function toggleMute() 
  local teams = hs.application.find("com.microsoft.teams")
  if not (teams == null) then
    hs.eventtap.keyStroke({"cmd","shift"}, "m", 0, teams)
  end
end

local modifiers = {"ctrl"}
hs.hotkey.bind(modifiers, "§", toggleMute)

local muteButton = hs.menubar.new()
local logo = hs.image.imageFromAppBundle("com.microsoft.teams")
logo:size({w=16,h=16})
muteButton:setIcon(logo)
muteButton:setClickCallback(toggleMute)
