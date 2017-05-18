function fish_right_prompt
    set -l last_status $status
    set -l timing (__sk_cmd_timing)
    set -l git_status (__sk_git_status)
    set -l last_color normal

    # status code
    if not test "$last_status" = "0"
        set_color $__sk_right_prompt_status_fg -b $__sk_right_prompt_status_bg
        echo -n -s ' ' $last_status ' '
        set_color normal
    end

    # cmd timing
    if test -n "$timing"
        set_color $__sk_right_prompt_timing_fg -b $__sk_right_prompt_timing_bg
        echo -n -s ' ' $timing ' '
        set_color normal
    end

    # git status
    if test -n "$git_status"
        set_color $__sk_right_prompt_git_fg -b $__sk_right_prompt_git_bg
        echo -n -s ' ' $git_status ' '
        set_color normal
    end

    echo ''
end
