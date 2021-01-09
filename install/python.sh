#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    black
    decorator
    mypy-lang
    pep8
    pyannotate
    pyflakes
    pylint
    pyls-black
    python-language-server
    virtualenv
    virtualfish
)

FORMULAS=(
    python@3.8
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
