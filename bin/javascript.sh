#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

MODULES=(
    gulp
)

FORMULAS="node"

npm_install() {
    for m in "${MODULES[@]}"; do
        printf "npm -g install --upgrade %s\n" "$m"
        npm -g install --upgrade "$m"
    done
}

main() {
    brew install ${FORMULAS}

    npm_install
}

main
