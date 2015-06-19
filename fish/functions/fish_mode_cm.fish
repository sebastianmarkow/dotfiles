function fish_mode_cm --description 'Displays the current mode'
  switch $fish_bind_mode
    case default
      set_color $__fish_vi_prompt_color_normal
      echo $__fish_vi_prompt_string_normal
    case insert
      set_color $__fish_vi_prompt_color_insert
      echo $__fish_vi_prompt_string_insert
    case visual
      set_color $__fish_vi_prompt_color_visual
      echo $__fish_vi_prompt_string_visual
  end
  set_color normal
end
