#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/dupes
    caskroom/cask
    caskroom/fonts
)

HEAD=(
#    neovim/neovim/neovim
)

EGGS=(
    neovim
)

FORMULAS=(
    awk
    bash
    bazaar
    coreutils
    curl
    diffutils
    fd
    findutils
    fish
    fzf
    ghq
    git
    gnu-sed
    gnu-tar
    grep
    iftop
    jump
    less
    make
    moreutils
    neovim
    openssh
    pam_yubico
    pidof
    pstree
    python3
    ripgrep
    rsync
    subversion
    tree
    watch
    wget
    xz
)

CASKS=(
    font-fira-code
)

h1 "base"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
