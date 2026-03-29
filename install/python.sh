#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    pyenv  # pyenv - Python version manager
    uv     # uv - fast Python package manager
)

MODULES=(
    pylatexenc  # pylatexenc - LaTeX to Unicode for render-markdown.nvim
)

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pip modules"
for m in "${MODULES[@]}"; do pip_install "$m"; done
