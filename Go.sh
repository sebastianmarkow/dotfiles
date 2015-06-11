#!/usr/bin/env bash

set -e

TOOLS=(
    "golang.org/x/tools/cmd/..."
    "code.google.com/p/rog-go/exp/cmd/godef"
    "github.com/nsf/gocode"
    "github.com/golang/lint/golint"
    "github.com/motemen/ghq"
    "github.com/motemen/gore"
)

go_get() {
    for t in "${TOOLS[@]}"; do
        printf "go get -u $t"
        go get -u $t
        printf " done\n"
    done
}

main() {
    go_get
}

main
