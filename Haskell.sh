#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

MODULES=(
    HsColour
    happy
    hoogle
)

cabal_up() {
    for m in "${MODULES[@]}"; do
        cabal install $m
    done
}

main() {
    cabal update

    cabal_up
}

main
