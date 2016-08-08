-- loading modules
local pipe = io.popen('ls ./modules/*.lua | sed "s/\\.lua$//g"')
for module in pipe:lines() do
    print("loading '" .. module .. "'")
    require(module)
end
pipe:close()

-- Install cli
hs.ipc.cliInstall()

-- Hostname
local hostname = hs.host.localizedName()
