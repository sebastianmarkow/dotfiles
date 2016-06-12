#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    pip
    pep8
    virtualenv
)

FORMULAS=(
    python3
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for e in "${EGGS[@]}"; do pip_install "$e"; done
