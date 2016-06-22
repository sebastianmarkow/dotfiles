#!/usr/local/bin/fish
# <bitbar.title>Docker status information</bitbar.title>
# <bitbar.author>Sebastian Klatt</bitbar.author>
# <bitbar.author.github>sebastianmarkow</bitbar.author.github>
# <bitbar.desc>List running Docker machines</bitbar.desc>
# <bitbar.dependencies>fish</bitbar.dependencies>

set -l machines (command docker-machine ls --format "{{.Name}}|{{.State}}|{{.DockerVersion}}|{{.DriverName}}")
or exit 1

set -l icon "iVBORw0KGgoAAAANSUhEUgAAABkAAAAQCAYAAADj5tSrAAAAAXNSR0IArs4c6QAAAYpJREFUOBHNlEsrRVEUxw95JiSvCQN3IHlMTCgfQEmJzMhEjOQbGBqbK5kpExMjs1MMZGKmiK7QHXhFNxKK31973/Y97X3vLQZW/dpr7fU/+7n2iaLSbAjZBRyUJs9XVeSHwaiWTAqqgooCCd8kzegn4R1uoQMysAZZCFkliY9QMtk/SMcXPMOe8TWB+q4hZIskVn1J30602hhe4AR0RJcQwx2ErJ/EEmzCuSsqd4IN/HuYhwHogy7jt5u2h1a7k24aXNPAZbACO7ANnRC5k9QT6z7qTCu/wfi6eMVN0Gj8alrXNOgrzMEopOEGfmaeotUAbaAJsqAJdQdvoAls3ye+qAEVhY60BXRUY7APC/AA0uXsEE8D/gXDuVEdR8f16MS/cbf4WAv2mirCtwtd8FUgl9Sn0em+gtZKRm/C/VClOgLriX5XY31dbgqCppKTdcMy6NWqT0UwAcUsRjADmWJCm1fZaVV2hYXaU3Sz4D4BQr/ZndisylUfj0Mv6Cj1D3uCMziGXTiC/2XfQuJ5JLN/Vr0AAAAASUVORK5CYII="

set -l num (count (echo $machines | grep 'Running'))
set -l cnum 0

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
            set -l ip (command docker-machine ip "$label")
            set items $items "$label ($state)| color=green"
            set items $items "--$driver ($version)"
            set items $items "--$ip"
            set items $items "-----"
            set items $items "--Stop| refresh=true terminal=false bash=/usr/local/bin/fish param1=-c param2=\"docker-machine stop $label\""
            set items $items "--Restart| refresh=true terminal=false bash=/usr/local/bin/fish param1=-c param2=\"docker-machine restart $label\""
            set items $items "-----"
            set items $items "--Upgrade| refresh=true terminal=false bash=/usr/local/bin/fish param1=-c param2=\"docker-machine upgrade $label\""
            set items $items "-----"
            set items $items "--Kill| refresh=true terminal=false bash=/usr/local/bin/fish param1=-c param2=\"docker-machine kill $label\""
            eval (command docker-machine env --shell fish "$label" | sed 's/\-gx/\-x/g')
            set -l containers (command docker ps -a --format "{{.Names}} ({{.Image}})|{{.ID}}|{{.Status}}")
            set cnum (math $cnum + (count (echo $containers | grep 'Up')))
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
            set items $items "$label ($state)| color=orange"
            set items $items "--$driver"
            set items $items "---"
        case '*'
            set items $items "$label ($state)| color=red"
            set items $items "--$driver"
            set items $items "-----"
            set items $items "--Start| refresh=true terminal=false bash=/usr/local/bin/fish param1=-c param2=\"docker-machine start $label\""
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
