#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/dupes
    homebrew/science
)

FORMULAS="vim --with-lua --with-luajit \
          grep --with-default-names \
          gnu-tar --with-default-names \
          gnu-sed --with-default-names
          laurent22/massren/massren \
          peco/peco/peco \
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
          imagemagick \
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
