#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

FORMULAS="cgdb \
        clang-format \
        deheader \
        gdb \
        make \
        mitchty/clang-scan-build/clang-scan-build \
        valgrind"

main() {
    brew install ${FORMULAS}
}

main
