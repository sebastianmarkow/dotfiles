function __fish_prompt_timing
    if set -q CMD_DURATION
        set -l seconds ''
        set -l minutes ''
        set -l hours ''
        set -l days ''
        set -l cmd_duration (math $CMD_DURATION/1000)
        if test $cmd_duration -gt 5
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
            echo -n -s ' (' $days $hours $minutes $seconds ')'
        end
    end
end
