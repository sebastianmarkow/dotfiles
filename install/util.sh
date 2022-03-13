#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    go-task/tap
    homebrew/cask
    homebrew/core
)

EGGS=(
    http-prompt
    proselint
    vim-vint
)

FORMULAS=(
    ankitpokhrel/jira-cli/jira-cli
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
    ugrep
    uncrustify
    upx
    vmtouch
    w3m
    wrk
    xo/xo/usql
    yank
    yq
)

CASKS=(
    arq
    alfred
    aerial
    hammerspoon
    hazel
    monitorcontrol
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
