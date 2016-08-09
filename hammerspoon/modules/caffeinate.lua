-- Caffeinate replacement menubar
local Caffeinate = {
    menubar = hs.menubar.new(),
    batteryCap = 10.0,
}

function Caffeinate:setIcon(state)
    if state then
        self.menubar:setIcon('./assets/caffeinate_active.pdf')
    else
        self.menubar:setIcon('./assets/caffeinate_inactive.pdf')
    end
end

function Caffeinate:toggle()
    self:setIcon(hs.caffeinate.toggle('displayIdle'))
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
    hs.hotkey.bind(hs.settings.get('leader'), 'c', 'Caffeinate toggle', function() Caffeinate:toggle() end)
end
