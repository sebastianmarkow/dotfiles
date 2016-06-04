function fish_prompt --description 'Compose fish prompt'
    echo -n -s (prompt_pwd) (__sk_prompt_sign) ' '
end
