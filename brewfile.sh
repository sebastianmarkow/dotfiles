#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
)

FORMULAS=(
    "go --cross-compile-common"
    "vim --with-lua --with-luajit"
    "zsh --disable-etcdir"
    "gnuplot --wx"
    "mtr --no-gtk"
    laurent22/massren/massren
    peco/peco/peco
    bash
    tmux
    git
    mercurial
    tig
    multitail
    ack
    cloc
    watch
    tree
    pv
    rename
    jq
    lftp
    nmap
    iftop
    htop
    rsync
    wget
    curl
    siege
    wrk
    tcpdump
    ttyrec
    tpp
    w3m
    graphviz
    gdb
    cgdb
    python
    python3
    ghc
    cabal-install
    node
)

brew_install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew_up() {
    for t in "${TAPS[@]}"; do brew tap $t; done
    for f in "${FORMULAS[@]}"; do brew install $f; done
}

main() {
    brew_install

    brew update
    brew outdated
    brew upgrade

    brew_up

    brew prune
    brew cleanup
    brew doctor
}

main
