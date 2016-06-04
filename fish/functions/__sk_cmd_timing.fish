function __sk_cmd_timing --description "Display execution time"
    if set -q CMD_DURATION
        set -l seconds ''
        set -l minutes ''
        set -l hours ''
        set -l days ''
        set -l cmd_duration (math $CMD_DURATION/1000)
        if test $cmd_duration -gt 0 # $__sk_cmd_timing_limit
            set seconds (math $cmd_duration%68400%3600%60)'s'
            if test $cmd_duration -ge 60
                set minutes (math $cmd_duration%68400%3600/60)'m'
                if test $cmd_duration -ge 3600
                    set hours (math $cmd_duration%68400/3600)'h'
                    if test $cmd_duration -ge 68400
                        set days (math $cmd_duration/68400)'d'
                    end
                end
            end
            echo -n -s "$__sk_cmd_timing_color $days$hours$minutes$seconds "
            set_color normal
        end
    end
end
