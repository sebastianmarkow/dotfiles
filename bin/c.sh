#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

FORMULAS="cgdb \
        clang-format \
        deheader \
        gdb \
        make \
        valgrind"

main() {
    brew install ${FORMULAS}
}

main
