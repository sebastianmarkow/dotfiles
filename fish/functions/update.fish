function update --description "Update system"

    set -l OSX_OUTDATED (softwareupdate --list --no-scan 2>&1 | grep "No new software available.")
    if test -z "$OSX_OUTDATED"
        echo -s (set_color red) "Update OS" (set_color normal)
        softwareupdate --install --all
    end

    echo -s (set_color red) "Update Homebrew" (set_color normal)
    brew update; and set -l BREW_OUTDATED (brew outdated)
    if test -n "$BREW_OUTDATED"
        echo -s (set_color red) "Update Formulas" (set_color normal)
        brew upgrade --all; and brew prune; and brew cleanup -s
        echo -s (set_color red) "Update Completion" (set_color normal)
        fish_update_completions
    end

    echo -s (set_color red) "Update Neovim" (set_color normal)
    nvim "+let g:plug_window=''" +PlugUpgrade +PlugClean! +PlugUpdate! +UpdateRemotePlugins +qall

end
