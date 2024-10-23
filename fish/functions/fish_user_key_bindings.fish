function fish_user_key_bindings
    bind \cr -M insert -m insert sk_history
    bind \cr -m insert sk_history
    bind \cf -M insert -m insert sk_filepath
    bind \cf -m insert sk_filepath
    bind \cs -M insert -m insert forward-char
    bind \cs -m insert forward-char
    bind \cx -M insert -m insert forward-bigword
    bind \cx -m insert forward-bigword
    bind \cp -M insert -m insert sk_file_edit
    bind \cp -m insert sk_file_edit
end
