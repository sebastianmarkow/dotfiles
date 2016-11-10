#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    bokeh
    ggplot
    jupyter
    keras
    pandas
    pandasql
    scikit-image
    scikit-learn
    seaborn
    tqdm
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
