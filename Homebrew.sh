#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/services
    homebrew/dupes
    homebrew/science
    homebrew/python
    laurent22/massren
)

FORMULAS="vim --with-lua --with-luajit --without-ruby --without-perl \
    ag \
    autojump \
    awk \
    bash \
    bzr \
    calc \
    cgdb \
    clang-format \
    cloc \
    coreutils \
    curl \
    diffutils \
    docker \
    docker-machine \
    docker-compose \
    docker-swarm \
    entr \
    fdupes \
    ffmpeg \
    findutils \
    fish \
    fzf \
    git \
    git-extras \
    gnu-sed \
    gnu-tar \
    gnuplot \
    go \
    hg \
    hub \
    iftop \
    imagemagick \
    jq \
    less \
    lftp \
    make \
    massren \
    moreutils \
    mtr \
    multitail \
    nmap \
    node \
    nq \
    openssh \
    pv \
    python \
        numpy \
        scipy \
        matplotlib \
    rename \
    rsync \
    since \
    tcpdump \
    tig \
    tmux \
    trash \
    tree \
    w3m \
    watch \
    wget \
    wrk \
    yank"

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
