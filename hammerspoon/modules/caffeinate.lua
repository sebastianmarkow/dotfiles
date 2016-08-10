-- Caffeinate replacement menubar
local Caffeinate = {
    menubar    = hs.menubar.new(),
    batteryCap = 10.0,
}

function Caffeinate:setIcon(state)
    if state then
        self.menubar:setIcon('./assets/caffeinate_active.pdf')
    else
        self.menubar:setIcon('./assets/caffeinate_inactive.pdf')
    end
end

function Caffeinate:toggle(silent)
    local state = hs.caffeinate.toggle('displayIdle')
    self:setIcon(state)
    if not silent then
        if state then
            hs.alert('Caffeinate on', 1)
        else
            hs.alert('Caffeinate off', 1)
        end
    end
end

function Caffeinate:batteryCallback()
    if hs.battery.powerSource() == 'Battery Power' then
        if hs.battery.percentage() <= self.batteryCap and hs.caffeinate.get('displayIdle') then
            self:toggle()
            hs.notify.show('Caffeinate disabled', '', 'Battery power below ' .. self.batteryCap .. '%')
        end
    end
end

if Caffeinate then
    Caffeinate.menubar:setTooltip('Caffeinate')
    Caffeinate.menubar:setClickCallback(function() Caffeinate:toggle() end)
    Caffeinate:setIcon(hs.caffeinate.get('displayIdle'))
    hs.battery.watcher.new(function() Caffeinate:batteryCallback() end):start()
    hs.hotkey.bind(hs.settings.get('leader'), 'c', function() Caffeinate:toggle() end)
end
