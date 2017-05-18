function fish_prompt --description 'Compose fish prompt'
    set -l last_color normal

    set_color $__sk_prompt_pwd_fg -b $__sk_prompt_pwd_bg
    echo -n -s ' ' (prompt_pwd) ' '

    if set -q VIRTUAL_ENV
        set_color $__sk_prompt_venv_fg -b $__sk_prompt_venv_bg
        echo -n -s " " (basename "$VIRTUAL_ENV") " "
    end

    if test "$USER" = "root"
        set_color $__sk_prompt_root_fg -b $__sk_prompt_root_bg
        echo -n -s ' root '
    end

    set_color normal
    echo ' '
end
