#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    buo/cask-upgrade
    homebrew/cask
    homebrew/cask-fonts
)

HEAD=()

EGGS=(
    proselint
    pynvim
    vim-vint
    yamllint
)

FORMULAS=(
    bash
    colima
    coreutils
    curl
    diffutils
    direnv
    docker
    fd # find replacement
    findutils
    fish
    fzf
    gawk
    gh
    gh
    ghq
    git
    git-crypt
    git-extras
    git-lfs
    gnu-sed
    gnu-tar
    gpg2
    grep
    grpcurl
    htop
    iftop
    jq
    jump
    less
    lf
    make
    massren
    moreutils
    mtr
    nmap
    pidof
    pstree
    rename
    ripgrep
    rsync
    since
    ssh-copy-id
    tcpdump
    tmux
    tree
    watch
    wget
    wrk
    xo/xo/usql
    xz
    yq
)

CASKS=(
    hammerspoon
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
