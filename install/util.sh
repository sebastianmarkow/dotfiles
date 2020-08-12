#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/cask
    homebrew/core
    homebrew/services
    xo/xo
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
    lftp
    lua
    luajit
    mandoc
    massren
    mtr
    multitail
    nmap
    pv
    ragel
    ranger
    rclone
    rename
    shellcheck
    since
    tcpdump
    terminal-notifier
    trash
    travis
    ugrep
    uncrustify
    upx
    usql
    vmtouch
    w3m
    wrk
    yank
)
CASKS=(
    hammerspoon
    kaleidscope
    monitorcontrol
    slack
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
