-- Homebrew menubar
local Homebrew = {
    menubar = hs.menubar.new(),
    outdated = false,
    items = {},
    header = {
        {title="Upgrade all", fn=function() os.execute("/usr/local/bin/brew upgrade --all"); Homebrew:refresh() end},
        {title="-"},
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
            table.insert(tableMenu, {title=item, fn=function() os.execute("/usr/local/bin/brew upgrade " .. item ); Homebrew:refresh() end})
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
    os.execute("/usr/local/bin/brew update")
end

function Homebrew:cron()
    Homebrew:update()
    Homebrew:refresh()
end

if Homebrew then
    Homebrew.menubar:removeFromMenuBar()
    Homebrew.menubar:setTooltip("Homebrew")
    Homebrew.menubar:setIcon("./assets/homebrew.pdf")
    Homebrew.cron(); hs.timer.new(3600, function() Homebrew:cron() end)
end
