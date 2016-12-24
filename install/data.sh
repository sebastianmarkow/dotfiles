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
    "homebrew/python/numpy --with-python3"
    "homebrew/python/scipy --with-python3"
    "homebrew/python/matplotlib --with-python3"
)

h1 "data science"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
