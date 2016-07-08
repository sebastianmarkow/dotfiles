#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

CRATES=(
    rustfmt
)

FORMULAS=(
    rust
)

h1 "rust"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "cargo crates"
for c in "${CRATES[@]}"; do cargo_install "$c"; done
