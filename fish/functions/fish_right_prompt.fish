function fish_right_prompt
    set -l last_status $status
    echo -n (__sk_git_status) (__sk_cmd_timing) (__sk_status_code $last_status)
end
