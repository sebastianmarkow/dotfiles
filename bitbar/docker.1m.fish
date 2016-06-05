#!/usr/local/bin/fish
# <bitbar.title>Docker status information</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List running Docker machines</bitbar.desc>
# <bitbar.dependencies>fish</bitbar.dependencies>

set -l dm (which docker-machine)
or exit 1
set -l d (which docker)
or exit 1

set -l icon "iVBORw0KGgoAAAANSUhEUgAAABoAAAAQCAYAAAAI0W+oAAAAAXNSR0IArs4c6QAAAZdJREFUOBGlk80rRUEYxg8O+Ui+UihuWdhbY3eThZ1SEn+Gva2w8hdY2NiQIh8rURI2vqKEUj4Kpexw/Z6auffc05lzTp2nfs07M8+ZM/POvJ6XXrNYv2E//SclZ2UpTIxqcNRDbaIzwuBHjGkoD1r0EXIgncAcPKsTowrmCjHzZVMPxrxgWn24ZOJjWpeqmNiCtrDBlTotHEd4HdvvJhiBRTtgWx3TapJgFG6gFdphB4ZB2gOl9A6U1k5YgQ2waib4BKV8CvrhCYIeb54BneIA7k3sSt2tmZ+hDWuZgWA2tun7fsB1RqwdBk90bsZks/M6UQN0wBVIupteGIIBWIULOIVNKCh1WkCmLKrjYz1/6R1yoJorSifSbpqKI9kDpbvsJ3ZJHTOY0yyxUlVtFw63444fHTI+Ab+O+fCGXvH1QaRUR2twCX+GD1r95Bp+QAsm6Q1DHvQaI2XrSHelp9oFLaCdqQZ0f0naxTANL0lGO99DoKIMp8TVP8KrAk8le6KgWbUwBoOgWmmEL9CzVYp14eugekqtfzBGhW68tV5IAAAAAElFTkSuQmCC"

set -l machines (command docker-machine ls -q)
set -l num 0
set -l cnum 0

for machine in $machines
    set -l state (command docker-machine status "$machine")
    switch "$state"
        case 'Running'
            set num (math "$num+1")
            set items $items " $machine | color=green terminal=false refresh=true bash=$dm param1=stop param2=$machine"
            eval (command docker-machine env --shell fish "$machine" | sed 's/\-gx/\-x/g')
            set -l containers (command docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")
            for container in $containers
                set -l clabel (echo $container | cut -d "|" -f 1)
                set -l cid (echo $container | cut -d "|" -f 2)
                set -l cstatus (echo $container | cut -d "|" -f 3)
                switch "$cstatus"
                    case 'Up*'
                        set ccolor "color=green"
                        set ccmd "stop"
                        set cnum (math "$cnum+1")
                    case 'Exited*'
                        set ccolor "color=red"
                        set ccmd "start"
                end
                if test "$container" = "$containers[-1]"
                    set sym "└"
                else
                    set sym "├"
                end
                set items $items "$sym $clabel| $ccolor terminal=false refresh=true bash=$d param1=$ccmd param2=$cid"
            end
        case '*'
            set items $items " $machine| color=red terminal=false refresh=true bash=$dm param1=start param2=$machine"
    end
end

if test $num -gt 0
    set sym "$num ($cnum)"
end

echo "$sym| templateImage=$icon dropdown=false"
echo "---"
for item in $items
    echo $item
end
