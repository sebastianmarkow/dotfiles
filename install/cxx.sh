#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

FORMULAS=(
    autoconf
    automake
    cgdb
    clang-format
    cmake
    deheader
    gdb
    llvm
    make
    rtags
    valgrind
)

h1 "c/cpp"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
