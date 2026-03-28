#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    go-task/tap
    homebrew/cask
    homebrew/core
)

FORMULAS=(
    bat # cat replacement with line numbers and syntax highlighting
    calc
    cloc
    cloog
    entr
    fdupes
    fx # json terminal viewer
    glow # markdown renderer with pager support (replaces mdcat)
    go-task
    graphviz
    hurl # scriptable HTTP request runner (.hurl files)
    jo
    lua
    luajit
    mandoc
    pv
    ragel
    rclone
    shellcheck
    terminal-notifier
    trash
    upx
    vmtouch
    w3m
    xh   # rust-based httpie-compatible HTTP client (replaces http-prompt)
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
