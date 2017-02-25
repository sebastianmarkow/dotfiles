-- install cli
if not hs.ipc.cliStatus() then
    hs.ipc.cliInstall()
end

-- leader
hs.settings.set('leader',      {'ctrl', 'alt'})
hs.settings.set('leadercmd',   {'ctrl', 'alt', 'cmd'})
hs.settings.set('leadershift', {'shift', 'ctrl', 'alt'})

-- hostname
local hostname = hs.host.localizedName()

-- host specific
if hostname == 'zhora' then -- zhora

elseif hostname == 'pris' then -- pris

else -- any

end

-- module: Redshift
hs.settings.set('Redshift.temperature', 2100)
hs.settings.set('Redshift.fade',        '1h')
hs.settings.set('Redshift.invert',      false)

-- loading modules
require('./modules/redshift')
require('./modules/caffeinate')
require('./modules/grid')
require('./modules/homebrew')
