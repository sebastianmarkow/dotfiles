#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
)

FORMULAS="vim --with-lua --with-luajit --without-python --without-ruby --without-perl \
    homebrew/dupes/rsync \
    homebrew/dupes/openssh \
    homebrew/dupes/make \
    homebrew/dupes/less \
    homebrew/dupes/awk \
    laurent22/massren/massren \
    coreutils \
    diffutils \
    findutils \
    moreutils \
    gnu-tar \
    gnu-sed \
    fish \
    bash \
    tmux \
    git \
    mercurial \
    bazaar \
    tig \
    multitail \
    ag \
    cloc \
    watch \
    tree \
    since \
    pv \
    rename \
    jq \
    peco \
    lftp \
    nmap \
    iftop \
    htop \
    wget \
    curl \
    mtr \
    wrk \
    w3m \
    gnuplot \
    graphviz \
    cgdb \
    go \
    python \
    python3 \
    ghc \
    cabal-install\
    node \
    syncthing"

brew_install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew_up() {
    for t in "${TAPS[@]}"; do brew tap $t; done
    brew install ${FORMULAS}
}

main() {
    brew_install

    brew doctor
    brew prune

    brew update
    brew outdated
    brew upgrade --all

    brew_up

    brew cleanup
}

main
