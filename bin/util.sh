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

FORMULAS="ag \
    bash \
    bzr \
    calc \
    cloc \
    coreutils \
    curl \
    devd \
    dlite \
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
    homebrew/dupes/awk \
    homebrew/dupes/diffutils \
    homebrew/dupes/less \
    homebrew/dupes/make \
    homebrew/dupes/openssh \
    homebrew/dupes/rsync \
    homebrew/dupes/tcpdump \
    htop \
    hub \
    iftop \
    imagemagick \
    irssi \
    jq \
    laurent22/massren/massren \
    lftp \
    mandoc \
    moreutils \
    mtr \
    multitail \
    neovim/neovim/neovim \
    nmap \
    pam_yubico \
    pstree \
    pv \
    ranger \
    rename \
    shellcheck \
    since \
    sshuttle \
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
    brew install ${FORMULAS}
}

main
