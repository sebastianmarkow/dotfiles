function fish_prompt --description 'Compose fish prompt'
    set_color 2c3e50 -b 95a5a6
    echo -n -s ' ' (prompt_pwd) ' '

    if test "$USER" = "root"
        set_color 95a5a6 -b bdc3c7
        echo -n -s ''
        set_color 7f8c8d
        echo -n -s ' root '
        set_color bdc3c7 -b normal
    else
        set_color 95a5a6 -b normal
    end


    echo -n -s ''
    set_color normal
    echo -n -s ' '
end
