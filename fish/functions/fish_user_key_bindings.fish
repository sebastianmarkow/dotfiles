function fish_user_key_bindings
    bind \cr -M insert -m insert ihistory
    bind \cr -m insert ihistory
    bind \cf -M insert -m insert __fzf_cmd
    bind \cf -m insert __fzf_cmd
end
