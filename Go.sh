#!/usr/bin/env bash

set -e

TOOLS=(
    "golang.org/x/tools/cmd/..."
    "github.com/motemen/ghq"
    "github.com/motemen/github-list-starred"
)

go_get() {
    for t in "${TOOLS[@]}"; do go get -v -u $t; done
}

main() {
    go_get
}

main
