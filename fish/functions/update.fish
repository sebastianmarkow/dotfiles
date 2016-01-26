function update --description "Update system"
    echo -s (set_color red) "Update OSX" (set_color normal)
    softwareupdate --install --all
    echo -s (set_color red) "Update Homebrew" (set_color normal)
    brew update; and set -l BREW_OUTDATED (brew outdated)
    if test -n "$BREW_OUTDATED"
        brew upgrade --all; and brew prune; and brew cleanup
        echo -s (set_color red) "Update Completion" (set_color normal)
        fish_update_completions
    end
    echo -s (set_color red) "Update Vim" (set_color normal)
    vim +PlugUpgrade +PlugClean! +PlugUpdate! +qall
end
