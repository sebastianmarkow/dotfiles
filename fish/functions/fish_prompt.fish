function fish_prompt --description 'Compose fish prompt'
    set -l last_color normal

    set_color $__sk_prompt_pwd_fg -b $__sk_prompt_pwd_bg
    echo -n -s ' ' (prompt_pwd) ' '
    set last_color $__sk_prompt_pwd_bg

    if test "$USER" = "root"
        set_color $last_color -b $__sk_prompt_root_bg
        echo -n -s ''
        set_color $__sk_prompt_root_fg -b $__sk_prompt_root_bg
        echo -n -s ' root '
        set last_color $__sk_prompt_root_bg
    end

    set_color $last_color -b normal
    echo -n -s ''
    set_color normal
    echo ' '
end
