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

    pip-review --auto

    command -s gcloud > /dev/null; and gcloud components update --quiet

    fisher update

    nvim "+let g:plug_window=''" +PlugUpgrade +PlugUpdate +PlugClean! +qall

    command -s flux > /dev/null; and flux completion fish > ~/.config/fish/completions/flux.gen.fish
    command -s kind > /dev/null; and kind completion fish > ~/.config/fish/completions/kind.gen.fish
    command -s colima > /dev/null; and colima completion fish > ~/.config/fish/completions/colima.gen.fish
    command -s direnv > /dev/null; and direnv hook fish > ~/.config/fish/completions/direnv.gen.fish

    exec fish
end
