#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

MODULES=(
    HsColour
    happy
    hoogle
)

FORMULAS="go"

cabal_install() {
    for m in "${MODULES[@]}"; do
        printf "cabal install $m\n"
        cabal install $m
    done
}

main() {
    brew install ${FORMULAS}

    cabal update
    cabal_install
}

main
