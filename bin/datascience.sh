#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

EGGS=(
    "scikit-learn"
    "pandas"
    "seaborn"
    "ipython[all]"
)

FORMULAS="python3 \
        homebrew/python/numpy \
        homebrew/python/scipy \
        homebrew/python/matplotlib"

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
