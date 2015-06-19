function fish_prompt --description 'Compose fish prompt'

    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l pwd_info (prompt_pwd)
    set -l git_info (__fish_git_prompt)
    set -l vi_cm (fish_mode_cm)
    set -l user_cm (fish_user_cm)

    echo -n -s $pwd_info $git_info ' ' $vi_cm ' ' $user_cm ' '
end
