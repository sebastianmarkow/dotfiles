function fish_vi_prompt --description 'Simple vi prompt'
    set -l last_status $status

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l pwd_info (prompt_pwd)
    set -l git_info (__fish_git_prompt)
    set -l vi_cm (__fish_vi_prompt_cm)
    set -l user_cm (__fish_user_prompt_cm)

    echo -n -s $pwd_info $git_info ' ' $vi_cm ' ' $user_cm ' '
end
