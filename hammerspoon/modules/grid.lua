-- Grid manager
local Grid = {
    margin = {0,0},
    resolution = {
	['2560x1440'] = '8x4',
	['1920x1080'] = '6x4',
	['1440x900']  = '4x2'
    },
    animationDuration = 0
}

function Grid:init()
    for r, g in pairs(self.resolution) do
        hs.grid.setGrid(g, r)
    end
    hs.grid.setMargins(self.margin)
    hs.window.animationDuration = self.animationDuration
end

if Grid then
    Grid:init()

    local leader = hs.settings.get('leader')
    hs.hotkey.bind(leader, 'h',      function() hs.grid.pushWindowLeft() end)
    hs.hotkey.bind(leader, 'l',      function() hs.grid.pushWindowRight() end)
    hs.hotkey.bind(leader, 'k',      function() hs.grid.pushWindowUp() end)
    hs.hotkey.bind(leader, 'j',      function() hs.grid.pushWindowDown() end)
    hs.hotkey.bind(leader, 'down',   function() hs.grid.resizeWindowTaller() end)
    hs.hotkey.bind(leader, 'up',     function() hs.grid.resizeWindowShorter() end)
    hs.hotkey.bind(leader, 'left',   function() hs.grid.resizeWindowThinner() end)
    hs.hotkey.bind(leader, 'right',  function() hs.grid.resizeWindowWider() end)
    hs.hotkey.bind(leader, 'space',  function() hs.grid.maximizeWindow() end)
    hs.hotkey.bind(leader, 'return', function() hs.grid.snap(hs.window.focusedWindow()) end)

    local leadermeta = hs.settings.get('leadermeta')
    hs.hotkey.bind(leadermeta, 'left',  'Move to previous screen', function() local win = hs.window.focusedWindow(); win:moveToScreen(win:screen():previous()) end)
    hs.hotkey.bind(leadermeta, 'right', 'Move to next screen',     function() local win = hs.window.focusedWindow(); win:moveToScreen(win:screen():next()) end)
end
