#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/cask
    homebrew/cask-fonts
)

HEAD=(
    neovim/neovim/neovim
)

EGGS=(
    pynvim
)

FORMULAS=(
    awk
    bash
    coreutils
    curl
    diffutils
    direnv
    fd
    findutils
    fish
    fzf
    ghq
    git
    git-lfs
    gnu-sed
    gnu-tar
    grep
    iftop
    jump
    less
    make
    moreutils
    pidof
    pstree
    python
    reattach-to-user-namespace
    ripgrep
    rsync
    ssh-copy-id
    tmux
    tree
    watch
    wget
    xz
)

CASKS=(
    docker
    font-fira-code
)

h1 "minimal"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
