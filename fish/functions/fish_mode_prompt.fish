function fish_mode_prompt --description 'Displays the current mode'
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color $__sk_mode_color_normal
                echo $__sk_mode_string_normal
            case insert
                set_color $__sk_mode_color_insert
                echo $__sk_mode_string_insert
            case replace-one
                set_color $__sk_mode_color_replace
                echo $__sk_mode_string_replace
            case visual
                set_color $__sk_mode_color_visual
                echo $__sk_mode_string_visual
        end
        set_color normal
        echo -n ' '
    end
end
