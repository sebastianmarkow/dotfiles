#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

TOOLS=(
    "github.com/alecthomas/gometalinter"
    "github.com/golang/lint/golint"
    "github.com/lukehoban/go-find-references"
    "github.com/lukehoban/go-outline"
    "github.com/mailgun/godebug"
    "github.com/motemen/gore"
    "github.com/newhook/go-symbols"
    "github.com/nsf/gocode"
    "github.com/pranavraja/tldr"
    "github.com/rogpeppe/godef"
    "github.com/tpng/gopkgs"
    "golang.org/x/tools/cmd/benchcmp"
    "golang.org/x/tools/cmd/cover"
    "golang.org/x/tools/cmd/godoc"
    "golang.org/x/tools/cmd/goimports"
    "golang.org/x/tools/cmd/gorename"
    "golang.org/x/tools/cmd/gorename"
    "golang.org/x/tools/cmd/stringer"
    "golang.org/x/tools/cmd/vet"
    "sourcegraph.com/sqs/goreturns"
)

FORMULAS="go"

go_get() {
    for t in "${TOOLS[@]}"; do
        printf "go get -u %s" "$t"
        go get -u "$t"
        printf " ...done\n"
    done
}

main() {
    brew install ${FORMULAS}
    go_get
}

main
