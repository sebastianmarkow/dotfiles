function upgrade --description "Upgrade system"
    set -l MACOS_OUTDATED (softwareupdate --list --no-scan 2>&1 | grep "No new software available.")
    if test -z "$MACOS_OUTDATED"
        softwareupdate --install --all
    end

    brew update
    and set -l BREW_OUTDATED (brew outdated)
    if test -n "$BREW_OUTDATED"
        brew upgrade
        fish_update_completions
    end

    set -l PIP_OUTDATED (pip3 list --outdated)
    if test -n "$PIP_OUTDATED"
        echo "$PIP_OUTDATED" | cut -f 1 -d " " | xargs pip3 install --upgrade
    end

    nvim "+let g:plug_window=''" +PlugUpgrade +PlugClean! +PlugUpdate! +UpdateRemotePlugins +qall
end
