#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/dupes
)

HEAD=(
    neovim/neovim/neovim
)

EGGS=(
    neovim
)

FORMULAS=(
    ag
    bash
    bazaar
    coreutils
    curl
    findutils
    fish
    fzf
    ghq
    git
    gnu-sed
    gnu-tar
    homebrew/dupes/awk
    homebrew/dupes/diffutils
    homebrew/dupes/grep
    homebrew/dupes/less
    homebrew/dupes/make
    homebrew/dupes/openssh
    homebrew/dupes/rsync
    iftop
    jump
    mercurial
    moreutils
    pam_yubico
    pstree
    subversion
    tree
    watch
    wget
    xz
)

h1 "base"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done