function fish_user_key_bindings
    # Each binding is duplicated to work in both normal and insert mode
    # First binding: starts from insert mode, executes command, keeps insert mode
    # Second binding: starts from any mode, switches to insert mode, executes command
    bind \cr -M insert -m insert fzf_history
    bind \cr -m insert fzf_history
    bind \cf -M insert -m insert fzf_filepath
    bind \cf -m insert fzf_filepath
    bind \cs -M insert -m insert forward-char
    bind \cs -m insert forward-char
    bind \cx -M insert -m insert forward-bigword
    bind \cx -m insert forward-bigword
    bind \cp -M insert -m insert fzf_file_edit
    bind \cp -m insert fzf_file_edit
end
