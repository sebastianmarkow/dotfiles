function fish_vi_prompt_cm --description 'Displays the current mode'
  switch $fish_bind_mode
    case default
      set_color red
      echo ' [n]'
    case insert
      set_color green
      echo ' [i]'
    case visual
      set_color magenta
      echo ' [v]'
  end
  set_color normal
end
