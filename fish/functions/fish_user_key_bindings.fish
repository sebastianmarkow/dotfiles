function fish_user_key_bindings
    bind \cr -M insert -m insert historyf
    bind \cr -m insert historyf
    bind \cs -M insert -m insert insert_filepath
    bind \cs -m insert insert_filepath
end
