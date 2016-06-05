#!/usr/local/bin/fish
# <bitbar.title>Homebrew updates</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List available updates from Homebrew</bitbar.desc>
# <bitbar.dependencies>fish,cut,wc,printf</bitbar.dependencies>

set -l brew /usr/local/bin/brew

command brew update >/dev/null; or exit 1

set -l formulas (command brew outdated -1 --verbose)
set -l num (string split '\n' $formulas | wc -l | string trim)

if test $num = "0"
    set num "✓"
end

echo "⇡$num | dropdown=false"
echo "---"

if test -n "$formulas"
    echo "Upgrade all | bash=$brew param1=upgrade param2=--all terminal=false refresh=true"
    for item in $formulas
        printf "%s | bash=$brew param1=upgrade param2=%s terminal=false refresh=true\n" $item (echo "$item" | cut -f 1 -d " ")
    end
end

