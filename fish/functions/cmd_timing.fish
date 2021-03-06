function cmd_timing --description "Display execution time"
    if set -q CMD_DURATION
        set -l seconds ''
        set -l minutes ''
        set -l hours ''
        set -l days ''
        set -l cmd_duration (math --scale=0 $CMD_DURATION/1000)
        if test "$cmd_duration" -ge "$cmd_timing_limit"
            set seconds (math --scale=0 $cmd_duration%68400%3600%60)'s'
            if test "$cmd_duration" -ge 60
                set minutes (math --scale=0 $cmd_duration%68400%3600/60)'m'
                if test "$cmd_duration" -ge 3600
                    set hours (math --scale=0 $cmd_duration%68400/3600)'h'
                    if test "$cmd_duration" -ge 68400
                        set days (math --scale=0 $cmd_duration/68400)'d'
                    end
                end
            end
            echo -n -s "$days$hours$minutes$seconds"
        end
    end
end
