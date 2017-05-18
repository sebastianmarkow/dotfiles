#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    bokeh
    csvkit
    cython
    fastcache
    gensim
    ggplot
    h5py
    joblib
    jupyter
    jupyter-contrib-nbextensions
    jupyter-nbextensions-configurator
    keras
    matplotlib
    more-itertools
    natsort
    nltk
    numpy
    pandas
    pandasql
    pydot-ng
    scikit-image
    scikit-learn
    scipy
    seaborn
    tensorflow
    tqdm
)

FORMULAS=(
    python3
    "homebrew/science/hdf5"
)

h1 "data science"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
h2 "jupyter notebook extensions"
execute "jupyter contrib nbextension install" "--user"
execute "jupyter nbextensions_configurator enable" "--user"
