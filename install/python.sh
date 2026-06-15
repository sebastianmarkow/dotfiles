#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/lib.sh"

# Homebrew formulas live in install/Brewfile.python (pyenv, uv).

MODULES=(
    pylatexenc  # pylatexenc - LaTeX to Unicode for render-markdown.nvim
)

h1 "python"
h2 "pipx packages"
for m in "${MODULES[@]}"; do pipx_install "$m"; done
