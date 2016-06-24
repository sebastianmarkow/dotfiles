#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

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
    http-prompt
    neovim
    proselint
    Sphinx
    vim-vint
)

FORMULAS=(
    ag
    bash
    bazaar
    calc
    catimg
    cloc
    cloog
    coreutils
    curl
    devd
    docker
    docker-compose
    docker-machine
    docker-machine-driver-xhyve
    docker-swarm
    entr
    fdupes
    ffmpeg
    findutils
    fzf
    ghq
    git
    git-extras
    gnu-sed
    gnu-tar
    gnuplot
    graphviz
    homebrew/dupes/awk
    homebrew/dupes/diffutils
    homebrew/dupes/grep
    homebrew/dupes/less
    homebrew/dupes/make
    homebrew/dupes/openssh
    homebrew/dupes/rsync
    homebrew/dupes/tcpdump
    htop
    iftop
    imagemagick
    irssi
    jo
    jq
    jump
    laurent22/massren/massren
    lftp
    mandoc
    mercurial
    moreutils
    mtr
    multitail
    nmap
    node
    pam_yubico
    pstree
    pv
    python3
    ragel
    rename
    shellcheck
    since
    subversion
    trash
    tree
    upx
    vmtouch
    w3m
    watch
    wget
    wrk
    xz
    yank
)

h1 "brew utilities"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew formulas (HEAD)"
for h in "${HEAD[@]}"; do brew_install "$h" "--HEAD"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
