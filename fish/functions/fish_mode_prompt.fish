function fish_mode_prompt --description 'Displays the current mode'
    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set sign_color $__sk_mode_color_normal
                set sign_char $__sk_mode_string_normal
            case insert
                set sign_color $__sk_mode_color_insert
                set sign_char $__sk_mode_string_insert
            case replace-one
                set sign_color $__sk_mode_color_replace
                set sign_char $__sk_mode_string_replace
            case visual
                set sign_color $__sk_mode_color_visual
                set sign_char $__sk_mode_string_visual
        end
        set_color -b $sign_color
        set_color white
        echo -n -s ' ' $sign_char ' '
        set_color $sign_color -b $__sk_prompt_pwd_bg
        echo -n -s ''
        set_color normal
    end
end
