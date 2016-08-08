-- Caffeinate replacement menubar
local caffeine = hs.menubar.new()
caffeine:setTitle("Caffeinate")
caffeine:setTooltip("Caffeinate")

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

-- Homebrew menubar
function getHomebrewOutdated()
    brew = io.popen("/usr/local/bin/brew outdated -1 --verbose")
    local outdated = {}
    for formula in brew:lines() do
        local full, name = formula, string.gmatch(formula, "%S+")[1]
        table.insert(outdated, {title=full, fn=function() os.execute("/usr/local/bin/brew upgrade " .. name); updateHomebrewMenu() end})
    end
    brew:close()
    return outdated
end

local homebrew = hs.menubar.new()
homebrew:removeFromMenuBar()
-- homebrew:setIcon("./icon/beer.pdf")
homebrew:setTitle("Brew")
homebrew:setTooltip("Homebrew")

local defaultMenu = {
    {title="Upgrade all", fn=function() os.execute("/usr/local/bin/brew upgrade --all"); updateHomebrewMenu() end},
    {title="-"},
}

function updateHomebrewMenu()
    local tableMenu = defaultMenu
    local outdated = getHomebrewOutdated()

    if (#outdated > 0) then
        for item in ipairs(outdated) do
            table.insert(tableMenu, item)
        end
        homebrew:returnToMenuBar()
        homebrew:setMenu(tableMenu)
    else
        homebrew:removeFromMenuBar()
        homebrew:setMenu(nil)
    end
end

function cronHomebrew()
    os.execute("/usr/local/bin/brew update")
    updateHomebrewMenu()
end

if homebrew then
    cronHomebrew()
    homebrewTimer = hs.timer.new(3600, cronHomebrew)
end
