#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

brew_install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

main() {
    brew_install

    brew update
    brew outdated

    brew upgrade --all

    brew cleanup
    brew prune
}

main
