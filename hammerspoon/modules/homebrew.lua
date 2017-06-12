-- Homebrew menubar
local Homebrew = {
    menubar  = hs.menubar.new(),
    items    = {},
    disabled = false,
    notified = false,
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
        self.notified = false
        self.menubar:removeFromMenuBar()
        self.menubar:setTooltip("Homebrew")
    else
        local msg = string.format("%d updated formula%s available", #self.items, plural(self.items))
        self.disabled = false
        self.menubar:returnToMenuBar()
        self.menubar:setTooltip(msg)
        if not self.notified then
            hs.notify.show('Homebrew', msg, table.concat(self.items, ', '))
            self.notified = true
        end
    end
end

function Homebrew:getMenu()
    local menu = {
        {title=string.format("Update %s formula%s", #self.items, plural(self.items)), fn=function() self.disabled = true; hs.task.new('/usr/local/bin/brew', function() Homebrew:loadOutdated() end, table.merge({'upgrade'}, self.items)):start() end, disabled=self.disabled},
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

function table.merge(t1, t2)
   for k,v in ipairs(t2) do
      table.insert(t1, v)
   end

   return t1
end

function plural(a)
    local suffix = ''
    if #a > 1 then
        suffix = 's'
    end
    return suffix
end

if Homebrew then
    Homebrew.menubar:setTooltip('Homebrew')
    Homebrew.menubar:setIcon('./assets/cask.pdf')
    Homebrew.menubar:setMenu(function() return Homebrew:getMenu() end)
    Homebrew.menubar:removeFromMenuBar()
    Homebrew:update(); hs.timer.doEvery(3600, function() Homebrew:update() end)
end
