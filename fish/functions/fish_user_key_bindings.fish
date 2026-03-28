function fish_user_key_bindings
    for mode in insert default
        bind -M $mode ctrl-r fzf_history
        bind -M $mode ctrl-f fzf_filepath
        bind -M $mode ctrl-s forward-char
        bind -M $mode ctrl-x forward-bigword
        bind -M $mode ctrl-p fzf_file_edit
    end
end
