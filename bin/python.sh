#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    "pip"
    "pep8"
    "virtualenv"
    "scikit-learn"
    "pandas"
    "seaborn"
    "ipython[all]"
)

FORMULAS="python \
        homebrew/python/numpy \
        homebrew/python/scipy \
        homebrew/python/matplotlib"

pip_install() {
    unset PIP_REQUIRE_VIRTUALENV
    for e in "${EGGS[@]}"; do
        printf "pip2 install --upgrade --quiet %s" "$e"
        pip2 install --upgrade --quiet "$e"
        printf " ...done\n"
    done
}

main() {
    brew install "${FORMULAS}"

    pip_install
}

main
