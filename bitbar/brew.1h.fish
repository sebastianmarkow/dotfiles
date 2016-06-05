#!/usr/local/bin/fish
# <bitbar.title>Homebrew updates</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List available updates from Homebrew</bitbar.desc>
# <bitbar.dependencies>fish,cut,wc,printf</bitbar.dependencies>

set -l brew /usr/local/bin/brew

command brew update >/dev/null; or exit 1

set -l formulas (command brew outdated -1 --verbose)
set -l num (count $formulas)

switch $num
    case '0'
        set sym "✓"
    case '*'
        set sym $num
end

echo "⇡$sym | dropdown=false"
echo "---"

if test -n "$formulas"
    echo "Upgrade all | bash=$brew param1=upgrade param2=--all terminal=false refresh=true"
    set -l i 1
    for item in $formulas
        switch $i
            case $num
                echo -n "└"
            case '*'
                echo -n "├"
        end
        printf " %s | bash=$brew param1=upgrade param2=%s terminal=false refresh=true\n" $item (echo "$item" | cut -f 1 -d " ")
        set i (math "$i+1")
    end
end
