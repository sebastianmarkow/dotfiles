#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    buo/cask-upgrade
)

FORMULAS=(
    atuin # shell history replacement with full-text search, timestamps, and stats
    bash
    btop
    colima
    coreutils
    curl
    delta
    diffutils
    direnv
    duf   # df replacement with color-coded disk usage overview
    dust  # du replacement with tree visualization
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
    gnupg
    grep
    bandwhich # network utilization by process/connection (replaces iftop)
    grpcurl
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
    procs # ps replacement with color, tree view, and filtering
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
    viddy # watch replacement with diff highlighting and TUI
    oha  # rust-based HTTP benchmarker with TUI histogram (replaces wrk)
    wget
    xo/xo/usql
    xz
    yazi
    yq
)

CASKS=(
    1password-cli
    font-jetbrains-mono-nerd-font
    hammerspoon
    kitty
)

h1 "minimal"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
