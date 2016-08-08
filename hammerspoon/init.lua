-- install cli
hs.ipc.cliInstall()

-- leader
hs.settings.set("leader", {"ctrl", "alt"})

-- hostname
local hostname = hs.host.localizedName()

-- window
hs.window.animationDuration = 0

-- zhora
if hostname == "zhora" then

end

-- pris
if hostname == "pris" then

end

-- loading modules
require("./modules/caffeinate")
require("./modules/redshift")
require("./modules/homebrew")
