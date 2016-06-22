function fish_user_key_bindings
    bind \cr -M insert -m insert historyf
    bind \cr -m insert historyf
    bind \cs -M insert -m insert insert_filepath
    bind \cs -m insert insert_filepath
    bind \cj -M insert -m insert down-or-search
    bind \cj -m insert down-or-search
    bind \ck -M insert -m insert up-or-search
    bind \ck -m insert up-or-search
end
