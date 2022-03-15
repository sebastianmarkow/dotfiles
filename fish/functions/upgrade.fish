function upgrade --description "Upgrade system"
    set -l MACOS_OUTDATED (softwareupdate --list --no-scan 2>&1 | grep "No new software available.")
    if test -z "$MACOS_OUTDATED"
        softwareupdate --install --all --agree-to-license
    end

    brew update
    and set -l BREW_OUTDATED (brew outdated -v | grep -v pinned)
    if test -n "$BREW_OUTDATED"
        brew upgrade --ignore-pinned --display-times
        brew cleanup --prune=30
        fish_update_completions
    end

    brew cu --yes --cleanup --no-brew-update

    command -s gcloud > /dev/null; and gcloud components update --quiet

    fisher update

    nvim "+let g:plug_window=''" +PlugUpgrade +PlugUpdate +PlugClean! +qall

    exec fish
end
