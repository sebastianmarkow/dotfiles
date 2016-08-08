-- Caffeinate replacement menubar
local caffeine = hs.menubar.new()
caffeine:setTooltip("Caffeinate")

function setCaffeineIcon(state)
    if state then
        caffeine:setIcon("./assets/caffeinate_active.pdf")
    else
        caffeine:setIcon("./assets/caffeinate_inactive.pdf")
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
local logger = hs.logger.new("homebrew", "debug")

function getHomebrewOutdated()
    local f = io.popen("/usr/local/bin/brew outdated -1 --quiet", "r")
    local outdated = false
    local items = {}
    for formula in f:lines() do
        table.insert(items, {title=formula, fn=function() os.execute("/usr/local/bin/brew upgrade " .. formula); updateHomebrewMenu() end})
        outdated = true
    end
    f:close()
    return outdated, items
end

local homebrew = hs.menubar.new()
homebrew:removeFromMenuBar()
homebrew:setIcon("./assets/homebrew.pdf")
homebrew:setTooltip("Homebrew")

local defaultMenu = {
    {title="Upgrade all", fn=function() os.execute("/usr/local/bin/brew upgrade --all"); updateHomebrewMenu() end},
    {title="-"},
}

function updateHomebrewMenu()
    homebrew:setMenu(nil)

    local tableMenu = {}
    tableMenu = defaultMenu
    local outdated, items = getHomebrewOutdated()

    if outdated then
        for i, item in ipairs(items) do
            table.insert(tableMenu, item)
        end
        homebrew:setMenu(tableMenu)
        homebrew:returnToMenuBar()
    else
        homebrew:removeFromMenuBar()
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
