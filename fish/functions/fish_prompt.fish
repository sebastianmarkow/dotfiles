function fish_prompt --description 'Compose fish prompt'

    set -l last_status $status
    set -l prompt_sign (__fish_prompt_sign)
    set -l sign

    switch $last_status
        case 0
            set sign $prompt_sign
        case 130
            set sign $prompt_sign
        case '*'
            set sign (set_color red)$__fish_prompt_sign_error(set_color normal)
    end

    echo -n -s (prompt_pwd) $sign ' '
end
