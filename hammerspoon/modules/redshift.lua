-- Redshift menubar
local Redshift = {
    menubar     = hs.menubar.new(),
    active      = false,
    temperature = hs.settings.get("Redshift.temperature"),
    start       = hs.settings.get("Redshift.start"),
    stop        = hs.settings.get("Redshift.stop"),
    fade        = hs.settings.get("Redshift.fade"),
    invert      = hs.settings.get("Redshift.invert"),
}

function Redshift:on(silent)
    self.active = true
    hs.settings.set('Redshift.active', self.active)
    self.menubar:setIcon('./assets/moon.pdf')
    hs.redshift.start(self.temperature, self.start, self.stop, self.fade, self.invert)
    if not silent then
        hs.alert.show('Redshift on', 1)
    end
end

function Redshift:off(silent)
    self.active = false
    hs.settings.set('Redshift.active', self.active)
    self.menubar:setIcon('./assets/sun.pdf')
    hs.redshift.stop()
    if not silent then
        hs.alert.show('Redshift off', 1)
    end
end

function Redshift:toggle(silent)
    if self.active then self:off(silent) else self:on(silent) end
end

if Redshift then
    Redshift.menubar:setTooltip('Toggle Redshift')
    Redshift.menubar:setClickCallback(function() Redshift:toggle() end)
    hs.hotkey.bind(hs.settings.get('leader'), 'r', function() Redshift:toggle() end)

    if hs.settings.get('Redshift.active') then Redshift:on(true) else Redshift:off(true) end
end
