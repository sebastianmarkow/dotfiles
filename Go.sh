#!/usr/bin/env bash

set -e

TOOLS=(
    "golang.org/x/tools/cmd/..."
    "code.google.com/p/rog-go/exp/cmd/godef"
    "github.com/nsf/gocode"
    "github.com/motemen/ghq"
)

go_get() {
    for t in "${TOOLS[@]}"; do go get -v -u $t; done
}

main() {
    go_get
}

main
