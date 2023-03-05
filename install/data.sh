#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    bokeh
    csvkit
    cython
    dvc
    fastcache
    h5py
    joblib
    jupyterlab
    matplotlib
    more-itertools
    natsort
    nltk
    numba
    numpy
    pandas
    pandasql
    pydot-ng
    scikit-image
    scikit-learn
    scikit-plot
    scipy
    seaborn
    spacy
    tensorflow
    tqdm
    umap-learn
)

FORMULAS=(
    hdf5
)

h1 "data science"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
