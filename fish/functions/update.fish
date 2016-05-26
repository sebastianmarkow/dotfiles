function update --description "Update system"

    set -l OSX_OUTDATED (softwareupdate --list --no-scan 2>&1 | grep "No new software available.")
    if test -z "$OSX_OUTDATED"
        softwareupdate --install --all
    end

    brew update; and set -l BREW_OUTDATED (brew outdated)
    if test -n "$BREW_OUTDATED"
        brew upgrade --all; and brew prune; and brew cleanup -s
        fish_update_completions
    end

    nvim "+let g:plug_window=''" +PlugUpgrade +PlugClean! +PlugUpdate! +UpdateRemotePlugins +qall

end
