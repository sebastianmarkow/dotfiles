function __fish_prompt_sign
    switch $USER
        case root
            echo $__fish_prompt_sign_root
        case '*'
            echo $__fish_prompt_sign_default
    end
end
