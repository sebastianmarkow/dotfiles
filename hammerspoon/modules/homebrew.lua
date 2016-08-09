-- Homebrew menubar
local Homebrew = {
    menubar = hs.menubar.new(),
    outdated = false,
    items = {},
    header = {
        {title="Upgrade all", fn=function() hs.task.new("/usr/local/bin/brew", function(code, stdout, stderr) Homebrew:refresh() end, {"upgrade", "--all"}) end},
        {title="-"}
    }
}

function Homebrew:loadOutdated()
    self.items = {}
    self.outdated = false
    local b = io.popen("/usr/local/bin/brew outdated -1 --quiet", "r")
    for formula in b:lines() do
        table.insert(self.items, formula)
        self.outdated = true
    end
    b:close()
end

function Homebrew:loadMenu()
    self.menubar:setMenu(nil)

    if self.outdated then
        local tableMenu = {}
        tableMenu = self.header
        for i, item in ipairs(self.items) do
            table.insert(tableMenu, {title=item, fn=function() hs.task.new("/usr/local/bin/brew", function(code, stdout, stderr) Homebrew:refresh() end, {"upgrade", item}):start() end})
        end
        self.menubar:setMenu(tableMenu)
        self.menubar:returnToMenuBar()
    else
        self.menubar:removeFromMenuBar()
    end

end

function Homebrew:refresh()
    self:loadOutdated()
    self:loadMenu()
end

function Homebrew:update()
    print("fetching homebrew")
    hs.task.new("/usr/local/bin/brew", function(code, stdout, stderr) Homebrew:refresh() end, {"update"}):start()
end

if Homebrew then
    Homebrew.menubar:removeFromMenuBar()
    Homebrew.menubar:setTooltip("Homebrew")
    Homebrew.menubar:setIcon("./assets/cask.pdf")
    Homebrew:update(); hs.timer.new(3600, function() Homebrew:update() end):start()
end
