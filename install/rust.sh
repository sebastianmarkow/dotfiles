#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/lib.sh"

# Homebrew formulas live in install/Brewfile.rust (rustup).

CRATES=(
    cargo-edit      # cargo-edit - manage dependencies (add/rm/upgrade)
    cargo-watch     # cargo-watch - re-run commands on file change
    cargo-nextest   # cargo-nextest - faster test runner
    cargo-audit     # cargo-audit - audit dependencies for vulnerabilities
    cargo-outdated  # cargo-outdated - check for outdated dependencies
    cargo-expand    # cargo-expand - expand macros for debugging
    bacon           # Bacon - background code checker TUI
    bottom          # Bottom - TUI system monitor
    tokei           # Tokei - code statistics
)

h1 "rust"
h2 "cargo crates"
for c in "${CRATES[@]}"; do cargo_install "$c"; done
