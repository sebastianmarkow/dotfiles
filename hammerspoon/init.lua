-- loading modules
local modules = io.popen('ls ./modules/*.lua | sed "s/\\.lua$//g"')
for module in modules:lines() do
    print("loading module in '" .. module .. "'")
    require(module)
end
modules:close()
