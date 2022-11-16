function fish_right_prompt
    set -l last_status $status
    set -l timing (cmd_timing)
    set -l last_color normal

    # status code
    if not test "$last_status" = "0"
        set_color $fish_color_prompt_status_fg -b $fish_color_prompt_status_bg
        echo -n -s ' ' $last_status ' '
        set_color normal
    end

    # cmd timing
    if test -n "$timing"
        set_color $fish_color_prompt_timing_fg -b $fish_color_prompt_timing_bg
        echo -n -s ' ' $timing ' '
        set_color normal
    end

    echo ''
end
