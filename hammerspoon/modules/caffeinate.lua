-- Caffeinate replacement menubar
local Caffeinate = {
    menubar = hs.menubar.new()
}

function Caffeinate:setIcon(state)
    if state then
        self.menubar:setIcon("./assets/caffeinate_active.pdf")
    else
        self.menubar:setIcon("./assets/caffeinate_inactive.pdf")
    end
end

function Caffeinate:toggle()
    self:setIcon(hs.caffeinate.toggle("displayIdle"))
end

if Caffeinate then
    Caffeinate.menubar:setTooltip("Caffeinate")
    Caffeinate.menubar:setClickCallback(function() Caffeinate:toggle() end)
    Caffeinate:setIcon(hs.caffeinate.get("displayIdle"))
end
