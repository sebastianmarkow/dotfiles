#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
)

FORMULAS="vim --with-lua --with-luajit \
          laurent22/massren/massren \
          peco/peco/peco \
          gnu-tar \
          gnu-sed \
          openssh \
          coreutils \
          diffutils \
          findutils \
          moreutils \
          zsh \
          bash \
          tmux \
          git \
          mercurial \
          tig \
          multitail \
          ack \
          cloc \
          watch \
          tree \
          since \
          gawk \
          pv \
          rename \
          jq \
          lftp \
          nmap \
          iftop \
          htop \
          wget \
          curl \
          mtr \
          siege \
          wrk \
          ttyrec \
          gnuplot \
          mdp \
          w3m \
          graphviz \
          cgdb \
          cmake \
          ctags \
          go \
          python \
          python3 \
          ghc \
          cabal-install\
          node \
          boot2docker \
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
    brew upgrade

    brew_up

    brew cleanup
    brew doctor
}

main
