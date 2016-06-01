function fish_prompt --description 'Compose fish prompt'

    set -l last_status $status

    switch $last_status
        case 0
            set last_status ''
        case '*'
            set last_status (set_color red) $__fish_prompt_sign_error (set_color normal)
    end

    echo -n -s $last_status (prompt_pwd) (__fish_prompt_sign) ' '
end
