#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

CRATES=(
    cargo-edit      # cargo add/rm/upgrade for dependency management
    cargo-watch     # watch files and re-run commands on change
    cargo-nextest   # next-gen test runner (faster, better output)
    cargo-audit     # audit dependencies for security vulnerabilities
    cargo-outdated  # check for outdated dependencies
    cargo-expand    # expand macros for debugging
    bacon           # background code checker TUI
    bottom          # cross-platform TUI system monitor (btm)
    tokei           # fast code statistics
)

FORMULAS=(
    rustup
)

h1 "rust"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "cargo crates"
for c in "${CRATES[@]}"; do cargo_install "$c"; done
