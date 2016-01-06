function update --description "Update system"
    echo -s (set_color red) "Updating OSX" (set_color normal)
    softwareupdate --install --all
    echo -s (set_color red) "Updating Homebrew" (set_color normal)
    brew update --all; and set -l brew_outdated (brew outdated); and brew upgrade --all; and brew cleanup; and brew prune
    if test -n "$brew_outdated"
        echo -s (set_color red) "Updating Fish completion" (set_color normal)
        fish_update_completions
    end
    echo -s (set_color red) "Updating vim plugins" (set_color normal)
    vim +PlugUpgrade +PlugClean! +PlugUpdate! +qall
end
