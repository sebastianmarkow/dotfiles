-- Homebrew menubar
local Homebrew = {
    menubar = hs.menubar.new(),
    items = {},
    disabled = false
}

function Homebrew:loadOutdated()
    local items, outdated = {}, false
    local b = io.popen('/usr/local/bin/brew outdated -1 --quiet', 'r')
    for formula in b:lines() do
        table.insert(items, formula)
        outdated = true
    end
    b:close()

    self.disabled = not outdated

    if outdated then
        self.items = items
        self.menubar:returnToMenuBar()
    else
        self.menubar:removeFromMenuBar()
        self.items = items
    end
end

function Homebrew:getMenu()
    local tableMenu = {
        {title='Upgrade all', fn=function() self.disabled = true; hs.task.new('/usr/local/bin/brew', function(code, stdout, stderr) Homebrew:loadOutdated() end, {'upgrade', '--all'}):start() end, disabled=self.disabled},
        {title='-'},
    }
    for i, item in ipairs(self.items) do
        table.insert(tableMenu, {title=item, fn=function() self.disabled = true; hs.task.new('/usr/local/bin/brew', function(code, stdout, stderr) Homebrew:loadOutdated() end, {'upgrade', item}):start() end, disabled=self.disabled})
    end

    return tableMenu
end

function Homebrew:update()
    print('Updating Homebrew')
    hs.task.new('/usr/local/bin/brew', function(code, stdout, stderr) Homebrew:loadOutdated() end, {'update'}):start()
end

if Homebrew then
    Homebrew.menubar:removeFromMenuBar()
    Homebrew.menubar:setTooltip('Homebrew')
    Homebrew.menubar:setIcon('./assets/cask.pdf')
    Homebrew.menubar:setMenu(function() return Homebrew:getMenu() end)
    Homebrew:update(); hs.timer.doEvery(3600, function() Homebrew:update() end)
end
