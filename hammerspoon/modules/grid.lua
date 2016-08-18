-- Grid manager
local Grid = {
    margin     = {0,0},
    resolution = {
	['2560x1440'] = '6x4',
	['1920x1200'] = '6x4',
	['1440x900']  = '4x2',
    },
    animationDuration = 0,
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
    hs.hotkey.bind(leader, 'space',  function() hs.grid.maximizeWindow() end)
    hs.hotkey.bind(leader, 'return', function() hs.grid.snap(hs.window.focusedWindow()) end)
    hs.hotkey.bind(leader, 'left',   function() local win = hs.window.focusedWindow(); win:moveToScreen(win:screen():toWest()) end)
    hs.hotkey.bind(leader, 'right',  function() local win = hs.window.focusedWindow(); win:moveToScreen(win:screen():toEast()) end)

    local leadershift = hs.settings.get('leadershift')
    hs.hotkey.bind(leadershift, 'h', function() hs.grid.resizeWindowThinner() end)
    hs.hotkey.bind(leadershift, 'l', function() hs.grid.resizeWindowWider() end)
    hs.hotkey.bind(leadershift, 'k', function() hs.grid.resizeWindowShorter() end)
    hs.hotkey.bind(leadershift, 'j', function() hs.grid.resizeWindowTaller() end)
end
