-- Redshift menubar
local Redshift = {
    menubar     = hs.menubar.new(),
    active      = false,
    temperature = hs.settings.get('Redshift.temperature'),
    start       = '20:00',
    stop        = '07:00',
    fade        = hs.settings.get('Redshift.fade'),
    invert      = hs.settings.get('Redshift.invert'),
}

local function getTimezoneOffset()
    local now = os.time()
    local utcdate   = os.date('!*t', now)
    local localdate = os.date('*t', now)
    localdate.isdst = false
    return os.difftime(os.time(localdate), os.time(utcdate)) / 3600
end

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

function Redshift:loadSunrise()
    hs.location.start()
    local location = hs.location.get()
    hs.location.stop()

    if not location then
        return
    end

    local lat, long = location['latitude'], location['longitude']
    local offset = getTimezoneOffset()
    local tomorrow = os.date('*t', os.time() + 86400)
    local sunset = os.date('%H:%M', hs.location.sunset(lat, long, offset))
    local sunrise = os.date('%H:%M', hs.location.sunrise(lat, long, offset, tomorrow))

    if self.start == sunset and self.stop == sunrise then
        return
    end

    self.start = sunset
    self.stop = sunrise

    if self.active then
        self:off(true)
        self:on(true)
    end
end

function Redshift:update()
    self:loadSunrise()
    self.menubar:setTooltip('Toggle Redshift (' .. self.start .. ' to ' .. self.stop .. ' at ' .. self.temperature .. 'K)')
end

if Redshift then
    Redshift.menubar:setTooltip('Toggle Redshift')
    Redshift.menubar:setClickCallback(function() Redshift:toggle() end)
    Redshift:update(); hs.timer.doAt('12:00', '1d', function() Redshift:update() end)
    hs.hotkey.bind(hs.settings.get('leader'), 'r', function() Redshift:toggle() end)

    if hs.settings.get('Redshift.active') then Redshift:on(true) else Redshift:off(true) end
end
