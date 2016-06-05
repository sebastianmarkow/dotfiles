function fish_right_prompt
    set -l last_status $status
    echo -n -s (__fish_git_prompt) (__sk_cmd_timing) (__sk_status_code $last_status)
end
