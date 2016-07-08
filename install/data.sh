#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    jupyter
    pandas
    scikit-learn
    seaborn
    ggplot
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
