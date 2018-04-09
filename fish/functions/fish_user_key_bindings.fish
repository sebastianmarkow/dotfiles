function fish_user_key_bindings
    bind \cr -M insert -m insert historyf
    bind \cr -m insert historyf
    bind \cf -M insert -m insert insert_filepath
    bind \cf -m insert insert_filepath
    bind \cs -M insert -m insert forward-char
    bind \cs -m insert forward-char
    bind \cp -M insert -m insert select_edit
    bind \cp -m insert select_edit
end
