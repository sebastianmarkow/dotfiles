function fish_vi_prompt_cm --description "Displays the current mode"
  echo -n " "
  switch $fish_bind_mode
    case default
      set_color red
      echo "[n]"
    case insert
      set_color green
      echo "[i]"
    case visual
      set_color magenta
      echo "[v]"
  end
  set_color normal
end

function fish_vi_prompt --description "Simple vi prompt"
        set -l last_status $status

        if not set -q __fish_prompt_normal
            set -g __fish_prompt_normal (set_color normal)
        end

        set -l pwd_info (prompt_pwd)
        set -l git_info (__fish_git_prompt)

        echo -n -s $pwd_info $git_info (fish_vi_prompt_cm) ' $ '
end
