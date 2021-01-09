function upgrade --description "Upgrade system"
    set -l MACOS_OUTDATED (softwareupdate --list --no-scan 2>&1 | grep "No new software available.")
    if test -z "$MACOS_OUTDATED"
        softwareupdate --install --all
    end

    brew update
    and set -l BREW_OUTDATED (brew outdated -v | grep -v pinned)
    if test -n "$BREW_OUTDATED"
        brew upgrade --ignore-pinned --display-times
        brew cleanup -s
        fish_update_completions
    end

    fisher update

    nvim "+let g:plug_window=''" +PlugClean! +PlugUpgrade +PlugUpdate! +UpdateRemotePlugins +qall

    exec fish
end
