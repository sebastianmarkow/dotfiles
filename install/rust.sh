#!/usr/bin/env bash

set -e

CRATES=(
    "rustfmt"
)

PATH=/usr/local/bin:$PATH

FORMULAS="rust"

cargo_install() {
    for c in "${CRATES}"; do
        printf "Install cargo crate %s" "$c"
        cargo install --quiet "$c"
        printf " ...done\n"
    done
}

main() {
    brew install ${FORMULAS}
    cargo_install
}

main
