#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
)

FORMULAS="vim --with-lua --with-luajit \
          laurent22/massren/massren \
          openssh \
          gnu-tar \
          gnu-sed \
          gawk \
          coreutils \
          diffutils \
          findutils \
          moreutils \
          fish \
          bash \
          tmux \
          git \
          mercurial \
          bazaar \
          tig \
          multitail \
          ack \
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
          gnuplot \
          mdp \
          w3m \
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

    brew update
    brew outdated
    brew upgrade --all

    brew_up

    brew cleanup
    brew doctor
}

main
