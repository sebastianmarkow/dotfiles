function __sk_prompt_sign --description "Display prompt sign"
    switch $USER
        case root
            echo $__sk_prompt_sign_root
        case '*'
            echo $__sk_prompt_sign_default
    end
end
