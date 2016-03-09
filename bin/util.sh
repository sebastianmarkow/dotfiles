#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
    homebrew/services
)

HEAD=(
    fish
    neovim/neovim/neovim
    tmux
)

FORMULAS="ag \
    bash \
    bzr \
    caius/jo/jo \
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
    homebrew/dupes/awk \
    homebrew/dupes/diffutils \
    homebrew/dupes/less \
    homebrew/dupes/make \
    homebrew/dupes/openssh \
    homebrew/dupes/rsync \
    homebrew/dupes/tcpdump \
    htop \
    iftop \
    imagemagick \
    irssi \
    jq \
    laurent22/massren/massren \
    lftp \
    mandoc \
    mercurial \
    moreutils \
    mtr \
    multitail \
    nmap \
    pam_yubico \
    pstree \
    pv \
    rename \
    shellcheck \
    since \
    subversion \
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
