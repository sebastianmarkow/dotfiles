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
)

FORMULAS=(
    bat # cat replacment with line numbers and syntax highlighting
    calc
    ccat # cat replacement with syntax highlighting
    cloc
    cloog
    entr
    fdupes
    fx # json terminal viewer
    go-task
    graphviz
    jo
    lua
    luajit
    mandoc
    mdcat
    pv
    ragel
    rclone
    shellcheck
    terminal-notifier
    trash
    upx
    vmtouch
    w3m
    yank
)

CASKS=(
    arq
    alfred
    aerial
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
