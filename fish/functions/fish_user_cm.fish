function fish_user_cm --description 'Display ps1'
    switch $USER
        case root
            set_color $__fish_user_prompt_color_root
            echo $__fish_user_prompt_string_root
        case '*'
            set_color $__fish_user_prompt_color_default
            echo $__fish_user_prompt_string_default
    end
end
