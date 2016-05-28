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

EGGS=(
    "neovim"
    "proselint"
    "vim-vint"
    "http-prompt"
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
    graphviz \
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
    jo \
    jq \
    jump \
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
    python3 \
    rename \
    shellcheck \
    since \
    subversion \
    trash \
    tree \
    upx \
    w3m \
    watch \
    wget \
    wrk \
    yank"


pip_install() {
    unset PIP_REQUIRE_VIRTUALENV
    for e in "${EGGS[@]}"; do
        printf "Install python module %s" "$e"
        pip3 install --upgrade --quiet "$e"
        printf " ...done\n"
    done
}

main() {
    for t in "${TAPS[@]}"; do brew tap "$t"; done
    for h in "${HEAD[@]}"; do brew install "$h" --HEAD; done
    brew install ${FORMULAS}

    pip_install
}

main
