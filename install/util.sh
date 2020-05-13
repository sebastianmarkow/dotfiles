#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/cask
    homebrew/core
    homebrew/services
)

EGGS=(
    http-prompt
    proselint
    sphinx
    vim-vint
)

FORMULAS=(
    caddy
    calc
    ccat
    cloc
    cloog
    devd
    entr
    fdupes
    ffmpeg
    git-extras
    graphviz
    htop
    imagemagick
    jo
    jq
    lua
    luajit
    mandoc
    massren
    mtr
    multitail
    nmap
    pv
    ragel
    rclone
    rename
    shellcheck
    since
    tcpdump
    trash
    travis
    uncrustify
    upx
    vmtouch
    w3m
    wrk
    yank
)

CASKS=(
    docker
    hammerspoon
    slack
    virtualbox
    virtualbox-extension-pack
)

h1 "utilities"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
