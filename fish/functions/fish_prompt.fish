function fish_prompt --description 'Write out the prompt'

    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l pwd_info (prompt_pwd)
    set -l git_info (__fish_git_prompt)

    echo -n -s $pwd_info $git_info ' $ '
end
