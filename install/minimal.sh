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
    virtualfish
)

FORMULAS=(
    bash
    coreutils
    curl
    diffutils
    direnv
    fd
    findutils
    fish
    fzf
    gawk
    ghq
    git
    git-crypt
    git-lfs
    gnu-sed
    gnu-tar
    gpg2
    grep
    iftop
    jump
    less
    lf
    make
    moreutils
    pidof
    pre-commit
    pstree
    python@3.9
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
    homebrew/cask/docker
    homebrew/cask-fonts/font-fira-code
)

h1 "minimal"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
