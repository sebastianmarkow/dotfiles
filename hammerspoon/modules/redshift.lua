-- Redshift menubar
local Redshift = {
    menubar = hs.menubar.new(),
    active = false,
    temperature = 2700,
    start = "20:00",
    stop = "08:00",
    fade = "2h",
    inverted = false,
    filter = hs.window.filter.new({loginwindow={visible=true, allowRoles='*'}}, 'wf-redshift')
}

function Redshift:on()
        self.active = true
        self.menubar:setIcon("./assets/moon.pdf")
        hs.redshift.start(self.temperature, self.start, self.stop, self.fade, self.inverted, self.filter)
end

function Redshift:off()
        self.active = false
        self.menubar:setIcon("./assets/sun.pdf")
        hs.redshift.stop()
end

function Redshift:toggle()
    if self.active then
        self:off()
    else
        self:on()
    end
end

if Redshift then
    Redshift.menubar:setTooltip("Redshift")
    Redshift.menubar:setClickCallback(function() Redshift:toggle() end)
    Redshift:on()
    hs.hotkey.bind('ctrl-alt', 'r', 'Redshift', function() Redshift:toggle() end)
end
