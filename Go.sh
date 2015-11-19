#!/usr/bin/env bash

set -e

TOOLS=(
    "golang.org/x/tools/cmd/..."
    "github.com/rogpeppe/godef"
    "github.com/nsf/gocode"
    "github.com/alecthomas/gometalinter"
    "github.com/mailgun/godebug"
    "github.com/motemen/ghq"
    "github.com/motemen/gore"
    "github.com/cortesi/devd/cmd/devd"
    "github.com/pranavraja/tldr"
)

go_get() {
    for t in "${TOOLS[@]}"; do
        printf "go get -u $t"
        go get -u $t
        printf " ...done\n"
    done
}

main() {
    go_get
}

main
