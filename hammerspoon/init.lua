-- install cli
if not hs.ipc.cliStatus() then
  hs.ipc.cliInstall()
end

-- leader
hs.settings.set('leader', {'ctrl', 'alt'})
hs.settings.set('leadercmd', {'ctrl', 'alt', 'cmd'})
hs.settings.set('leadershift', {'shift', 'ctrl', 'alt'})

-- hostname
local hostname = hs.host.localizedName()

-- host specific
if hostname == 'tyrell' then
elseif hostname == 'pris' then
else -- any
end

-- loading modules
require('./modules/caffeinate')
require('./modules/grid')
require('./modules/ms-teams')
