-- Redshift menubar
local Redshift = {
    menubar     = hs.menubar.new(),
    active      = false,
    temperature = 2700,
    start       = '20:00',
    stop        = '08:00',
    fade        = '2h',
    inverted    = false,
}

function Redshift:on()
    self.active = true
    hs.settings.set('Redshift.active', self.active)
    self.menubar:setIcon('./assets/moon.pdf')
    hs.redshift.start(self.temperature, self.start, self.stop, self.fade, self.inverted)
end

function Redshift:off()
    self.active = false
    hs.settings.set('Redshift.active', self.active)
    self.menubar:setIcon('./assets/sun.pdf')
    hs.redshift.stop()
end

function Redshift:toggle()
    if self.active then self:off() else self:on() end
end

if Redshift then
    Redshift.menubar:setTooltip('Redshift')
    Redshift.menubar:setClickCallback(function() Redshift:toggle() end)
    hs.hotkey.bind(hs.settings.get('leader'), 'r', 'Redshift toggle', function() Redshift:toggle() end)

    if hs.settings.get('Redshift.active') then Redshift:on() else Redshift:off() end
end
