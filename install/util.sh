#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    homebrew/core
    homebrew/services
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
    mplayer
    mtr
    multitail
    nmap
    pv
    ragel
    rclone
    ruby
    rename
    shellcheck
    since
    tcpdump
    trash
    uncrustify
    upx
    vmtouch
    w3m
    wrk
    yank
)

GEMS=(
    travis
)

CASKS=(
    hammerspoon
    virtualbox
    virtualbox-extension-pack
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
h2 "ruby gems"
for f in "${GEMS[@]}"; do gem_install "$f"; done
