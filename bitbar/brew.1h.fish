#!/usr/local/bin/fish
# <bitbar.title>Homebrew updates</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List available updates from Homebrew</bitbar.desc>
# <bitbar.dependencies>fish,cut,wc,printf</bitbar.dependencies>

command brew update ^ /dev/null > /dev/null
or exit 1

set -l icon "iVBORw0KGgoAAAANSUhEUgAAAA8AAAARCAQAAACoAz4qAAAA7UlEQVQoFQXBPyuEARwA4Od97yVy13v+lDpn0nUb0xnUKWG4SfEJTGwmqw9wZbHYb7Ao+QBsuroyKQZXDISMV3SJfp6nAKBl3aOSMUMAMkzaN+9dz5VnP2709XwDnGnakGBZKnHqwCUAHaMAADoSyHDiTsOha21ASVsA8Kuia1cIIYSBW2ukKCpg1hYAzk27UIKqUPEphBBCWLEqbKbIcWQKAOT6mMmQYw8AUFbDa4YyAAC2LXrRTZEDAGDHQMtfijIAAI413JMiBwDABJBK1AEAsGAEmPMkhBBCCCF8WIIE1NRVFY0b+vKm70HAP3Q8RCuxKyTxAAAAAElFTkSuQmCC"

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
