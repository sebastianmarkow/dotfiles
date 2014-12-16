#!/bin/sh

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
    git-flow
    tig
    homebrew/dupes/grep
    homebrew/dupes/less
    laurent22/massren/massren
    peco/peco/peco
    ack
    cloc
    watch
    tree
    pv
    rename
    jq
    multitail
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
    grap
    sqlite
    gdb
    cgdb
    "go --cross-compile-common"
    python3
    ghc
    cabal-install
    node
    automake
    autoconf
    cmake
    ctags
    graphviz
)

function install() {
    [ -x "/usr/local/bin/brew" ] || {
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"    
    }
}

function brew_up() {
    for tap in "${TAPS[@]}"; do
        brew tap $tap
    done

    for formula in "${FORMULAS[@]}"; do
        brew install $formula
    done
}

function main() {
    install

    brew update
    brew upgrade

    brew_up

    brew cleanup -s -f
    brew doctor
    brew prune
}

main
