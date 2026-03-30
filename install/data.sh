#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    bokeh           # Bokeh - interactive web visualization
    csvkit          # csvkit - CSV command-line tools
    cython          # Cython - C-extensions for Python
    dvc             # DVC - data version control
    fastcache       # fastcache - fast in-memory cache
    h5py            # h5py - HDF5 file format for Python
    joblib          # Joblib - parallel computing
    jupyterlab      # JupyterLab - interactive notebook IDE
    matplotlib      # Matplotlib - plotting library
    more-itertools  # more-itertools - extended itertools
    natsort         # natsort - natural string sorting
    nltk            # NLTK - natural language processing
    numba           # Numba - JIT compiler for Python
    numpy           # NumPy - numerical computing
    pandas          # pandas - data analysis and manipulation
    pandasql        # pandasql - SQL queries on DataFrames
    pydot-ng        # pydot-ng - Graphviz interface
    scikit-image    # scikit-image - image processing
    scikit-learn    # scikit-learn - machine learning
    scikit-plot     # scikit-plot - ML visualization
    scipy           # SciPy - scientific computing
    seaborn         # Seaborn - statistical visualization
    spacy           # spaCy - NLP library
    tensorflow      # TensorFlow - deep learning framework
    tqdm            # tqdm - progress bars
    umap-learn      # UMAP - dimensionality reduction
)

FORMULAS=(
    hdf5  # HDF5 - hierarchical data format library
)

h1 "data science"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pipx packages"
for e in "${EGGS[@]}"; do pipx_install "$e"; done
