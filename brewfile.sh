#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
    laurent22/massren
    peco/peco
)

FORMULAS=(
    zsh
    bash
    tmux
    "vim --with-lua --with-luajit"
    git
    tig
    homebrew/dupes/grep
    homebrew/dupes/less
    laurent22/massren/massren
    peco/peco/peco
    grap
    ack
    cloc
    watch
    tree
    pv
    rename
    jq
    mtr
    nmap
    iftop
    wget
    curl
    siege
    wrk
    tcpdump
    w3m
    "gnuplot --wx"
    graphviz
    gdb
    cgdb
    "go --cross-compile-common"
    python3
    ghc
    cabal-install
    node
)

install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew_up() {
    for t in "${TAPS[@]}"; do brew tap $t; done
    for f in "${FORMULAS[@]}"; do brew install $f; done
}

main() {
    install

    brew update
    brew upgrade

    brew_up

    brew cleanup -s -f
    brew doctor
    brew prune
}

main
