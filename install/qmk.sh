#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    qmk/qmk
)

FORMULAS=(
    qmk
)

h1 "qmk"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
