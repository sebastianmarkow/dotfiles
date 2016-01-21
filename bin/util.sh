#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/services
    homebrew/dupes
    homebrew/science
)

HEAD=(
    fish
)

FORMULAS="vim --with-lua --with-luajit --without-ruby --without-perl \
    ag \
    awk \
    bash \
    bzr \
    calc \
    cloc \
    coreutils \
    curl \
    devd \
    diffutils \
    docker \
    docker-compose \
    docker-machine \
    docker-swarm \
    entr \
    fdupes \
    ffmpeg \
    findutils \
    fzf \
    ghq \
    git \
    git-extras \
    gnu-sed \
    gnu-tar \
    gnuplot \
    gsamokovarov/jump/jump \
    hg \
    hub \
    iftop \
    imagemagick \
    jq \
    laurent22/massren/massren \
    less \
    lftp \
    make \
    moreutils \
    mtr \
    multitail \
    nmap \
    nq \
    openssh \
    pam_yubico \
    pv \
    ranger \
    rename \
    rsync \
    since \
    sshuttle \
    tcpdump \
    tmux \
    trash \
    tree \
    w3m \
    watch \
    wget \
    wrk \
    yank"

main() {
    for t in "${TAPS[@]}"; do brew tap "$t"; done
    for h in "${HEAD[@]}"; do brew install "$h" --HEAD; done
    brew install "${FORMULAS}"
}

main
