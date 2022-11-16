function fish_prompt --description 'Compose fish prompt'
    set -l last_color normal
    set -l git_status (git_status)

    # git status
    if test -n "$git_status"
        set_color $fish_color_prompt_git_fg -b $fish_color_prompt_git_bg
        echo -n -s ' ' $git_status ' '
        set_color normal
    end

    set_color $fish_color_prompt_pwd_fg -b $fish_color_prompt_pwd_bg
    echo -n -s ' ' (prompt_pwd) ' '

    if set -q VIRTUAL_ENV
        set_color $fish_color_prompt_venv_fg -b $fish_color_prompt_venv_bg
        echo -n -s " " (basename "$VIRTUAL_ENV") " "
    end

    if test "$USER" = "root"
        set_color $fish_color_prompt_root_fg -b $fish_color_prompt_root_bg
        echo -n -s ' root '
    end

    set_color normal
    echo ' '
end
