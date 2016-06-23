#!/usr/local/bin/fish
# <bitbar.title>Homebrew updates</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List available updates from Homebrew</bitbar.desc>
# <bitbar.dependencies>fish,cut,wc,printf</bitbar.dependencies>

command brew update ^ /dev/null > /dev/null
or exit 1

set -l icon "iVBORw0KGgoAAAANSUhEUgAAAA0AAAAQCAQAAABnqj2yAAAA2klEQVQYGQXBMSuEAQAG4Oe+7yOdfBYlnNJRBoPFWWT0K2wGg0H5Bwb5AzfJwGS1qKvrVhnULUYlA5Eyia5ueD1PicKcK/smHVn3AEBHz0Bb4daiAwM3FoCuGQA0tKw6g8q9E+cW/NkGdAwBhrb0HYuIeHZomQpNDZUJAGsu/NiBDx2vxiIiHrV96haoTZtSAZj1om+jUmkaKAFQo2FUqFECgNq8PUNWRERERMTIuxabIiIiIuLUEuyKiIiIiDYUagAA1EBPRERERFxC6cvYWKVQ+vXtyZ1rb/wDfLxUtQtQYsQAAAAASUVORK5CYII="

set -l formulas (command brew outdated -1 --verbose)
set -l num (count $formulas)

switch "$num"
    case '0'
    case '*'
        set sym "⇡$num"
end

echo "$sym| templateImage=$icon dropdown=false"
echo "---"
echo "Update| refresh=true"
echo "---"

if test -n "$formulas"
    set -l brew (command -s brew)
    echo "Upgrade all| bash=$brew param1=upgrade param2=--all terminal=false refresh=true"
    for item in $formulas
        if test "$item" = "$formulas[-1]"
            echo -n "└"
        else
            echo -n "├"
        end
        printf " %s| bash=$brew param1=upgrade param2=%s terminal=false refresh=true\n" $item (echo "$item" | cut -f 1 -d " ")
    end
end

echo "---"
echo "Prune| refresh=true terminal=false bash=$brew param1=prune"
echo "Cleanup| refresh=true terminal=false bash=$brew param1=cleanup"
