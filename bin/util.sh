#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

HEAD=(
    fish
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
    docker-compose \
    docker-machine \
    docker-swarm \
    entr \
    fdupes \
    ffmpeg \
    findutils \
    fzf \
    git \
    git-extras \
    gnu-sed \
    gnu-tar \
    gnuplot \
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
    rename \
    rsync \
    since \
    sshuttle \
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

main() {
    for h in "${HEAD[@]}"; do brew install $h --HEAD; done
    brew install ${FORMULAS}
}

main
