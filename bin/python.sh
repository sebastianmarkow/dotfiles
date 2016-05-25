#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    "pip"
    "pep8"
    "virtualenv"
    "neovim"
    "http-prompt"
)

FORMULAS="python3"

pip_install() {
    unset PIP_REQUIRE_VIRTUALENV
    for e in "${EGGS[@]}"; do
        printf "pip3 install --upgrade --quiet %s" "$e"
        pip3 install --upgrade --quiet "$e"
        printf " ...done\n"
    done
}

main() {
    brew install ${FORMULAS}

    pip_install
}

main
