#!/usr/local/bin/fish
# <bitbar.title>Docker status information</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List running Docker machines</bitbar.desc>
# <bitbar.dependencies>fish</bitbar.dependencies>

command -s docker-machine > /dev/null ^ /dev/null
and command -s docker > /dev/null ^ /dev/null
or exit 1

set -l icon "iVBORw0KGgoAAAANSUhEUgAAABoAAAAQCAYAAAAI0W+oAAAAAXNSR0IArs4c6QAAAZdJREFUOBGlk80rRUEYxg8O+Ui+UihuWdhbY3eThZ1SEn+Gva2w8hdY2NiQIh8rURI2vqKEUj4Kpexw/Z6auffc05lzTp2nfs07M8+ZM/POvJ6XXrNYv2E//SclZ2UpTIxqcNRDbaIzwuBHjGkoD1r0EXIgncAcPKsTowrmCjHzZVMPxrxgWn24ZOJjWpeqmNiCtrDBlTotHEd4HdvvJhiBRTtgWx3TapJgFG6gFdphB4ZB2gOl9A6U1k5YgQ2waib4BKV8CvrhCYIeb54BneIA7k3sSt2tmZ+hDWuZgWA2tun7fsB1RqwdBk90bsZks/M6UQN0wBVIupteGIIBWIULOIVNKCh1WkCmLKrjYz1/6R1yoJorSifSbpqKI9kDpbvsJ3ZJHTOY0yyxUlVtFw63444fHTI+Ab+O+fCGXvH1QaRUR2twCX+GD1r95Bp+QAsm6Q1DHvQaI2XrSHelp9oFLaCdqQZ0f0naxTANL0lGO99DoKIMp8TVP8KrAk8le6KgWbUwBoOgWmmEL9CzVYp14eugekqtfzBGhW68tV5IAAAAAElFTkSuQmCC"

set -l machines (command docker-machine ls --format "{{.Name}}|{{.State}}|{{.DockerVersion}}|{{.DriverName}}")
set -l num (count (echo $machines | grep 'Running'))

for machine in $machines
    set -l label (echo $machine | cut -d "|" -f 1)
    set -l state (echo $machine | cut -d "|" -f 2)
    set -l version (echo $machine | cut -d "|" -f 3)
    set -l driver (echo $machine | cut -d "|" -f 4)

    if test "$version" = "Unknown" -a "$state" = "Running"
        set state 'Pending'
    end
    switch "$state"
        case 'Running'
            set items $items "$label ($state) $version $driver| color=green terminal=false refresh=true bash=/usr/local/bin/fish param1=-c param2=\"docker-machine stop $label\""
            eval (command docker-machine env --shell fish "$label" | sed 's/\-gx/\-x/g')
            set -l containers (command docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")
            for container in $containers
                set -l clabel (echo $container | cut -d "|" -f 1)
                set -l cid (echo $container | cut -d "|" -f 2)
                set -l cstatus (echo $container | cut -d "|" -f 3)
                if test "$container" = "$containers[-1]"; set sym "└"; else; set sym "├"; end
                switch "$cstatus"
                    case 'Up*'
                        set items $items "$sym $clabel| color=green terminal=false refresh=true bash=/usr/local/bin/fish param1=-c param2=\"eval (docker-machine env --shell fish $label); docker stop $cid\""
                    case 'Exited*'
                        set items $items "$sym $clabel| color=red terminal=false refresh=true bash=/usr/local/bin/fish param1=-c param2=\"eval (docker-machine env --shell fish $label); docker start $cid\""
                end
            end
            set items $items "---"
        case 'Pending'
            set items $items "$label ($state) $driver| color=orange"
            set items $items "---"
        case '*'
            set items $items "$label ($state) $driver| color=red terminal=false refresh=true bash=/usr/local/bin/fish param1=-c param2=\"docker-machine start $label\""
            set items $items "---"
    end
end

if test $num -gt 0
    set sym "$num"
end

echo "$sym| templateImage=$icon dropdown=false"
echo "---"
for item in $items
    echo $item
end
