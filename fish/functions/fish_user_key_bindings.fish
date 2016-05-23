function fish_user_key_bindings
    bind \cr -M insert -m insert ihistory
    bind \cr -m insert ihistory
    bind \cs -M insert -m insert insert_filepath
    bind \cs -m insert insert_filepath
end
