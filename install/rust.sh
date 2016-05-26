#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

FORMULAS="rust"

main() {
    brew install ${FORMULAS}
}

main
