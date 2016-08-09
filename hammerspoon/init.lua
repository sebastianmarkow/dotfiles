-- install cli
if not hs.ipc.cliStatus() then
    hs.ipc.cliInstall()
end

-- leader
hs.settings.set('leader', {'ctrl', 'alt'})
hs.settings.set('leadermeta', {'shift', 'ctrl', 'alt'})

-- hostname
local hostname = hs.host.localizedName()


-- host specific
if hostname == 'zhora' then -- zhora

elseif hostname == 'pris' then -- pris

else -- any

end

-- loading modules
require('./modules/redshift')
require('./modules/caffeinate')
require('./modules/grid')
require('./modules/homebrew')
