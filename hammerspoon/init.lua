local caffeine = hs.menubar.new()

function setCaffeineIcon(state)
    if state then
        caffeine:setIcon("./icon/caffeine-on.pdf")
    else
        caffeine:setIcon("./icon/caffeine-off.pdf")
    end
end

function caffeineClicked()
    setCaffeineIcon(hs.caffeinate.toggle("displayIdle"))
end

if caffeine then
    caffeine:setClickCallback(caffeineClicked)
    setCaffeineIcon(hs.caffeinate.get("displayIdle"))
end
