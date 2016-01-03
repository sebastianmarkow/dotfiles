#!/usr/bin/env bash

set -e

TOOLS=(
    "golang.org/x/tools/cmd/benchcmp"
    "golang.org/x/tools/cmd/cover"
    "golang.org/x/tools/cmd/godoc"
    "golang.org/x/tools/cmd/goimports"
    "golang.org/x/tools/cmd/gorename"
    "golang.org/x/tools/cmd/stringer"
    "golang.org/x/tools/cmd/vet"
    "github.com/rogpeppe/godef"
    "github.com/nsf/gocode"
    "github.com/alecthomas/gometalinter"
    "github.com/mailgun/godebug"
    "github.com/motemen/ghq"
    "github.com/motemen/gore"
    "github.com/cortesi/devd/cmd/devd"
    "github.com/pranavraja/tldr"
)

FORMULAS="go"

go_get() {
    for t in "${TOOLS[@]}"; do
        printf "go get -u $t"
        go get -u $t
        printf " ...done\n"
    done
}

main() {
    brew install ${FORMULAS}
    go_get
}

main
