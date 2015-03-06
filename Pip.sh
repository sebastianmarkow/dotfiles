#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    virtualenv
    virtualenvwrapper
    pep8
)

pip_up() {
    unset PIP_REQUIRE_VIRTUALENV
    for p in pip pip3
    do
        for e in "${EGGS[@]}"; do $p install --upgrade --quiet $e; done
    done
}

main() {
    pip_up
}

main
