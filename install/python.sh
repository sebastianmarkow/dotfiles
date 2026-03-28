#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    uv  # uv - fast Python package manager
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
