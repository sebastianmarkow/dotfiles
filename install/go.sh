#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TOOLS=(
    github.com/alecthomas/gometalinter
    github.com/golang/tools/gopls
    github.com/lukehoban/go-outline
    github.com/mailgun/godebug
    github.com/motemen/gore
    github.com/newhook/go-symbols
    github.com/nsf/gocode
    github.com/rogpeppe/godef
    github.com/tools/godep
    github.com/tpng/gopkgs
    golang.org/x/lint/golint
    golang.org/x/tools/gopls
    sourcegraph.com/sqs/goreturns
)

FORMULAS=(
    go
)

h1 "go"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
