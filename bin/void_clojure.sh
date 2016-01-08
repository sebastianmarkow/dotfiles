#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

FORMULAS="leiningen"

main() {
    brew install ${FORMULAS}
}

main
