function fish_mode_prompt --description 'Displays the current mode'
  if set -q __fish_vi_mode
    switch $fish_bind_mode
      case default
        set_color $__fish_mode_color_normal
        echo $__fish_mode_string_normal
      case insert
        set_color $__fish_mode_color_insert
        echo $__fish_mode_string_insert
      case replace-one
        set_color $__fish_mode_color_replace
        echo $__fish_mode_string_replace
      case visual
        set_color $__fish_mode_color_visual
        echo $__fish_mode_string_visual
    end
    set_color normal
    echo -n ' '
  end
end
