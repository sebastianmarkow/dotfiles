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
    "github.com/rogpeppe/godef"
    "github.com/tpng/gopkgs"
    "golang.org/x/tools/cmd/..."
    "honnef.co/go/unused/cmd/unused"
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
