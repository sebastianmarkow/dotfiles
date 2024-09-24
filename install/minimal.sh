#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    buo/cask-upgrade
    homebrew/cask
    homebrew/cask-fonts
)

FORMULAS=(
    bash
    btop
    colima
    coreutils
    curl
    delta
    diffutils
    direnv
    docker
    fd # find replacement
    findutils
    fish
    fzf
    gawk
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
    iftop
    jq
    lazygit
    less
    make
    massren
    moreutils
    mtr
    neovim
    nmap
    nvtop
    pidof
    pstree
    rename
    ripgrep
    rsync
    since
    ssh-copy-id
    starship
    tcpdump
    tmux
    tree
    watch
    wget
    wrk
    xo/xo/usql
    xz
    yazi
    yq
)

CASKS=(
    1password-cli
    alacritty
    hammerspoon
    homebrew/cask-fonts/font-jetbrains-mono-nerd-font
    homebrew/cask-fonts/font-maple
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
