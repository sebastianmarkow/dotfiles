#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    ipython[all]
    pandas
    scikit-learn
    seaborn
)

FORMULAS=(
    python3
    homebrew/python/numpy
    homebrew/python/scipy
    homebrew/python/matplotlib
)

h1 "data science"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
