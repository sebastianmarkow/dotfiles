#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/dupes
    homebrew/science
    homebrew/services
)

EGGS=(
    Sphinx
    http-prompt
    proselint
    vim-vint
)

FORMULAS=(
    calc
    catimg
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
    git-extras
    gnuplot
    graphviz
    homebrew/dupes/tcpdump
    htop
    imagemagick
    jo
    jq
    laurent22/massren/massren
    lftp
    mandoc
    mtr
    multitail
    nmap
    node
    pv
    python3
    ragel
    rename
    shellcheck
    since
    tmux
    trash
    upx
    vmtouch
    w3m
    wrk
    yank
)

h1 "utilities"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
