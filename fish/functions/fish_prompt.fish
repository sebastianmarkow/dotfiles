function fish_prompt --description 'Compose fish prompt'

    set -l last_status $status

    set -l status_string ''
    if test $status -ne 0
        set status_string (set_color red --bold) '(' $last_status ') ' (set_color normal)
    end

    set -l virtualenv_string ''
    if set -q VIRTUAL_ENV
        set virtualenv_string ' ' (set_color brown) '(' (basename "$VIRTUAL_ENV") ')' (set_color normal)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    set -l pwd_string (prompt_pwd)
    set -l git_string (__fish_git_prompt)
    set -l mode_string (fish_mode_cm)
    set -l user_string (fish_user_cm)

    echo -n -s $status_string $pwd_string $virtualenv_string $git_string ' ' $mode_string ' ' $user_string ' '
end
