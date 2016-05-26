#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    "pip"
    "pep8"
    "virtualenv"
)

FORMULAS="python3"

pip_install() {
    unset PIP_REQUIRE_VIRTUALENV
    for e in "${EGGS[@]}"; do
        printf "Install python module %s" "$e"
        pip3 install --upgrade --quiet "$e"
        printf " ...done\n"
    done
}

main() {
    brew install ${FORMULAS}

    pip_install
}

main
