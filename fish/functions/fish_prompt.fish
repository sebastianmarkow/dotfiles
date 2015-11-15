function fish_prompt --description 'Compose fish prompt'

    set -l last_status $status
    set -l prompt_sign (__fish_prompt_sign)
    set -l sign $prompt_sign

    if test $last_status -ne 0
        set sign (set_color red)$__fish_prompt_sign_error(set_color normal)
    end

    echo -n (prompt_pwd) $sign ''
end
