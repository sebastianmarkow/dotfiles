function fish_right_prompt

    set -l last_status $status
    set -l duration (__fish_prompt_timing)
    switch $last_status
        case 0
            set last_status ''
        case '*'
            set last_status (set_color red) ' (' $last_status ')' (set_color normal)
    end

    echo -s -n $duration $last_status (__fish_git_prompt)
end
