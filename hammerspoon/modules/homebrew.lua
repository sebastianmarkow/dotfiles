-- Homebrew menubar
local Homebrew = {
    menubar  = hs.menubar.new(),
    items    = {},
    disabled = false,
}

function Homebrew:loadOutdated()
    self.items = {}
    local pipe = io.popen('/usr/local/bin/brew outdated -1 --quiet', 'r')
    for item in pipe:lines() do
        table.insert(self.items, item)
    end
    pipe:close()

    if next(self.items) == nil then
        self.disabled = true
        self.menubar:removeFromMenuBar()
    else
        self.disabled = false
        self.menubar:returnToMenuBar()
    end
end

function Homebrew:getMenu()
    local menu = {
        {title='Upgrade all', fn=function() self.disabled = true; hs.task.new('/usr/local/bin/brew', function() Homebrew:loadOutdated() end, {'upgrade', '--all'}):start() end, disabled=self.disabled},
        {title='-'},
    }
    for _, item in ipairs(self.items) do
        table.insert(menu, {title=item, fn=function() self.disabled = true; hs.task.new('/usr/local/bin/brew', function() Homebrew:loadOutdated() end, {'upgrade', item}):start() end, disabled=self.disabled})
    end

    return menu
end

function Homebrew:update()
    print('Updating Homebrew')
    hs.task.new('/usr/local/bin/brew', function() Homebrew:loadOutdated() end, {'update'}):start()
end

if Homebrew then
    Homebrew.menubar:removeFromMenuBar()
    Homebrew.menubar:setTooltip('Homebrew')
    Homebrew.menubar:setIcon('./assets/cask.pdf')
    Homebrew.menubar:setMenu(function() return Homebrew:getMenu() end)
    Homebrew:update(); hs.timer.doEvery(3600, function() Homebrew:update() end)
end
