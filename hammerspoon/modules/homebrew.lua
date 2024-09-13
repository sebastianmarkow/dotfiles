-- Homebrew menubar
local Homebrew = { menubar = hs.menubar.new(), items = {}, disabled = false, notified = false }

function Homebrew:showMenu()
  self.menubar:returnToMenuBar()
  self.menubar:setIcon('./assets/cask.pdf')
  self.menubar:setTooltip(string.format('%d updated formula%s available', #self.items, plural(self.items)))
end

function Homebrew:hideMenu()
  self.menubar:removeFromMenuBar()
end

function Homebrew:loadOutdated()
  self.items = {}
  local pipe = io.popen('/usr/local/bin/brew outdated -v | grep -v pinned | cut -f 1 -d " "', 'r')
  for item in pipe:lines() do
    table.insert(self.items, item)
  end
  pipe:close()

  if next(self.items) == nil then
    self.disabled = true
    self.notified = false
    self:hideMenu()
  else
    self.disabled = false
    self:showMenu()
    if not self.notified then
      hs.notify.show('Homebrew', 'Formulas updated', table.concat(self.items, ', '))
      self.notified = true
    end
  end
end

function Homebrew:getMenu()
  local menu = {
    {
      title = string.format('Update %s formula%s', #self.items, plural(self.items)),
      fn = function()
        self.disabled = true
        hs.task
          .new('/usr/local/bin/brew', function()
            Homebrew:loadOutdated()
          end, table.merge({ 'upgrade' }, self.items))
          :start()
      end,
      disabled = self.disabled,
    },
    { title = '-' },
  }
  for _, item in ipairs(self.items) do
    table.insert(menu, {
      title = item,
      fn = function()
        self.disabled = true
        hs.task
          .new('/usr/local/bin/brew', function()
            Homebrew:loadOutdated()
          end, { 'upgrade', item })
          :start()
      end,
      disabled = self.disabled,
    })
  end

  return menu
end

function Homebrew:update()
  print('Updating Homebrew')
  hs.task
    .new('/usr/local/bin/brew', function()
      Homebrew:loadOutdated()
    end, { 'update' })
    :start()
end

function table.merge(t1, t2)
  for k, v in ipairs(t2) do
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
  Homebrew:hideMenu()
  Homebrew.menubar:setMenu(function()
    return Homebrew:getMenu()
  end)
  Homebrew:update()
  hs.timer.doEvery(3 * 3600, function()
    Homebrew:update()
  end)
end
