function __fish_prompt_git
    if not type 'git' >/dev/null 2>&1
        return
    end

    set -l git_state (command git rev-parse --git-dir --is-inside-git-dir --is-bare-repository --is-inside-work-tree HEAD ^/dev/null)


    switch $git_state[4]
        case 'true'
            set git_status (__fish_git_status)
        case '*'
            echo "no"
            return
    end

    echo -n -s $git_status
end

function __fish_git_status
    echo "status"
end
