-- install cli
if not hs.ipc.cliStatus() then
  hs.ipc.cliInstall()
end

-- leader
hs.settings.set('leader', { 'ctrl', 'alt' })
hs.settings.set('leadercmd', { 'ctrl', 'alt', 'cmd' })
hs.settings.set('leadershift', { 'shift', 'ctrl', 'alt' })

-- hostname
local hostname = hs.host.localizedName()

-- host specific
if hostname == 'tyrell' then
elseif hostname == 'pris' then
else -- any
end

-- Setup garbage collection to reduce memory usage
collectgarbage("setpause", 160)
collectgarbage("setstepmul", 200)

-- Asynchronously load modules
local function loadModuleAsync(name)
  hs.timer.doAfter(0.1, function()
    require('./modules/' .. name)
  end)
end

-- Priority module - load immediately
require('./modules/grid')

-- Load other modules asynchronously
loadModuleAsync('caffeinate')
loadModuleAsync('ms-teams')
loadModuleAsync('homebrew')
