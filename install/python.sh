#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    decorator
    mypy-lang
    pep8
    pyannotate
    pylint
    virtualenv
    virtualfish
    yapf
)

FORMULAS=(
    python3
    pyenv
    pipenv
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
