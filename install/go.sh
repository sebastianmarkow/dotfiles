#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TOOLS=(
    github.com/alecthomas/gometalinter
    github.com/golang/lint/golint
    github.com/lukehoban/go-outline
    github.com/mailgun/godebug
    github.com/motemen/gore
    github.com/newhook/go-symbols
    github.com/nsf/gocode
    github.com/rogpeppe/godef
    github.com/tools/godep
    github.com/tpng/gopkgs
    golang.org/x/tools/cmd/...
    honnef.co/go/unused/cmd/unused
    sourcegraph.com/sqs/goreturns
)

FORMULAS=(
    go
)

h1 "go"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
