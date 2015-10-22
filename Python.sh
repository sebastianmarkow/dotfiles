#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    pip
    pep8
    virtualenv
    virtualfish
    scikit-learn
    pandas
    seaborn
    ipython[all]
)

pip_up() {
    unset PIP_REQUIRE_VIRTUALENV
    for p in pip2
    do
        for e in "${EGGS[@]}"; do
            printf "$p install --upgrade $e"
            $p install --upgrade --quiet $e
            printf " ...done\n"
        done
    done
}

main() {
    pip_up
}

main
