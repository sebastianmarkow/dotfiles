#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/dupes
    homebrew/science
    homebrew/services
    caskroom/cask
)

EGGS=(
    awscli
    http-prompt
    proselint
    sphinx
    vim-vint
)

FORMULAS=(
    calc
    ccat
    cloc
    cloog
    devd
    docker
    docker-compose
    docker-machine
    docker-machine-driver-xhyve
    docker-swarm
    entr
    fdupes
    ffmpeg
    gistit
    git-extras
    graphviz
    homebrew/dupes/tcpdump
    htop
    imagemagick
    jo
    jq
    laurent22/massren/massren
    lua
    luajit
    mandoc
    mpg123
    mplayer
    mtr
    multitail
    nmap
    pv
    python3
    ragel
    rename
    shellcheck
    since
    tmux
    trash
    uncrustify
    upx
    vmtouch
    w3m
    wrk
    yank
)

CASKS=(
    hammerspoon
)

h1 "utilities"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
