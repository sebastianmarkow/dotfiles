function fish_right_prompt
    set -l last_status $status
    set -l timing (__sk_cmd_timing)
    set -l last_color normal

    # cmd timing
    if test -n "$timing"
        set_color $__sk_right_prompt_timing_bg -b $last_color
        echo -n -s ''
        set_color $__sk_right_prompt_timing_fg -b $__sk_right_prompt_timing_bg
        echo -n -s ' ' $timing ' '
        set last_color $__sk_right_prompt_timing_bg
        set_color normal
    end

    # status code
    if test "$last_status" -gt 0
        set_color $__sk_right_prompt_status_bg -b $last_color
        echo -n -s ''
        set_color $__sk_right_prompt_status_fg -b $__sk_right_prompt_status_bg
        echo -n -s ' ' $last_status ' '
        set last_color $__sk_right_prompt_status_bg
        set_color normal
    end

    echo ''
end
