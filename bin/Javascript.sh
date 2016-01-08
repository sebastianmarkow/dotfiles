#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

MODULES=(
    gulp
    shout
)

FORMULAS="node"

npm_install() {
    for m in "${MODULES[@]}"; do
        printf "npm -g install --upgrade $m\n"
        npm -g install --upgrade $m
    done
}

main() {
    brew install ${FORMULAS}

    npm_install
}

main
