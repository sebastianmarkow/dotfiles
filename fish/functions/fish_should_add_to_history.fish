function fish_should_add_to_history
    # Don't add commands starting with a space (like bash/zsh's HISTIGNORE=' *')
    not string match -q ' *' -- $argv[1]
end
