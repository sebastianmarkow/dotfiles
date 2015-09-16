#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
    homebrew/python
)

FORMULAS="vim --with-lua --with-luajit --without-ruby --without-perl \
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
    hg \
    bzr \
    tig \
    multitail \
    ag \
    cloc \
    watch \
    entr \
    tree \
    since \
    pv \
    rename \
    jq \
    autojump \
    peco \
    spark \
    lftp \
    nmap \
    iftop \
    htop \
    wget \
    curl \
    mtr \
    wrk \
    tcpdump \
    w3m \
    gnuplot \
    cgdb \
    go \
    python3 \
    node"

#   ghc \
#   cabal-install\

brew_install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew_up() {
    for t in "${TAPS[@]}"; do brew tap $t; done
    brew install ${FORMULAS}
}

main() {
    brew_install

    brew update
    brew prune

    brew outdated
    brew upgrade --all

    brew_up

    brew cleanup
}

main
