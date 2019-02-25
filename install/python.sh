#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    decorator
    mypy-lang
    #neovim
    pep8
    pyannotate
    pylint
    virtualenv
    virtualfish
    yapf
)

FORMULAS=(
    python
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
