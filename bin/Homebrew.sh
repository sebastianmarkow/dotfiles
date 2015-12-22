#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TAPS=(
    homebrew/services
    homebrew/dupes
    homebrew/science
)

brew_install() {
    [ -x "/usr/local/bin/brew" ] || ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

brew_taps() {
    for t in "${TAPS[@]}"; do brew tap $t; done
}

main() {
    brew_install
    brew_taps

    brew update
    brew prune

    brew outdated
    brew upgrade --all

    brew cleanup
}

main
