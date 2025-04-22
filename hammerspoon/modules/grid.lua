-- Grid manager with optimizations for latency
local Grid = {
  margin = { 0, 0 },
  resolution = { ['3008x1692'] = '6x4', ['2560x1440'] = '6x4', ['1920x1200'] = '6x4', ['1440x900'] = '4x2' },
  animationDuration = 0, -- Keep zero for fastest response
  windowCache = {},      -- Cache focused window for better performance
}

function Grid:init()
  -- Apply grid settings in a single loop
  for r, g in pairs(self.resolution) do
    hs.grid.setGrid(g, r)
  end
  hs.grid.setMargins(self.margin)
  hs.window.animationDuration = self.animationDuration
end

function Grid:getFocusedWindow()
  -- Cache focused window to reduce system calls
  local now = hs.timer.secondsSinceEpoch()
  if not self.windowCache.time or (now - self.windowCache.time) > 0.5 then
    self.windowCache.window = hs.window.focusedWindow()
    self.windowCache.time = now
  end
  return self.windowCache.window
end

-- Clear the cache when windows change
hs.window.filter.default:subscribe(hs.window.filter.windowCreated, function()
  Grid.windowCache = {}
end)

if Grid then
  Grid:init()

  -- Define key mappings in a more structured way
  local hotkeys = {
    -- Command leader hotkeys
    [hs.settings.get('leadercmd')] = {
      h = function() 
        local win = Grid:getFocusedWindow()
        if win then
          hs.layout.apply({ { nil, win, win:screen(), hs.layout.left50, nil, nil } })
        end
      end,
      l = function() 
        local win = Grid:getFocusedWindow()
        if win then
          hs.layout.apply({ { nil, win, win:screen(), hs.layout.right50, nil, nil } })
        end
      end
    },
    
    -- Regular leader hotkeys
    [hs.settings.get('leader')] = {
      h = function() hs.grid.pushWindowLeft() end,
      l = function() hs.grid.pushWindowRight() end,
      k = function() hs.grid.pushWindowUp() end,
      j = function() hs.grid.pushWindowDown() end,
      space = function() hs.grid.maximizeWindow() end,
      return_key = function() 
        local win = Grid:getFocusedWindow()
        if win then
          hs.grid.snap(win)
        end
      end,
      left = function()
        local win = Grid:getFocusedWindow()
        if win then
          win:moveToScreen(win:screen():toWest())
        end
      end,
      right = function()
        local win = Grid:getFocusedWindow()
        if win then
          win:moveToScreen(win:screen():toEast())
        end
      end
    },
    
    -- Shift leader hotkeys
    [hs.settings.get('leadershift')] = {
      h = function() hs.grid.resizeWindowThinner() end,
      l = function() hs.grid.resizeWindowWider() end,
      k = function() hs.grid.resizeWindowShorter() end,
      j = function() hs.grid.resizeWindowTaller() end
    }
  }
  
  -- Register all hotkeys in a single loop to improve startup time
  for modifiers, keymap in pairs(hotkeys) do
    for key, fn in pairs(keymap) do
      if key == "return_key" then key = "return" end -- Special case for return
      hs.hotkey.bind(modifiers, key, fn)
    end
  end
end
