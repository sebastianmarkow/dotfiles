function fish_user_key_bindings
    bind \cr -M insert -m insert ihistory
    bind \cr -m insert ihistory
    bind \cp -M insert -m insert __fzf_cmd $HOME
    bind \cp -m insert __fzf_cmd $HOME
end
