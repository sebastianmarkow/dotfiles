#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    go-task/tap
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
    bat
    caddy
    calc
    ccat
    cloc
    cloog
    devd
    entr
    fdupes
    ffmpeg
    fx
    gh
    git-extras
    go-task/tap/go-task
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
    mdcat
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
    yq
)

CASKS=(
    aerial
    github
    hammerspoon
    kaleidoscope
    michaelvillar-timer
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
