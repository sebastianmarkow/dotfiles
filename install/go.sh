#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TOOLS=(
    github.com/lukehoban/go-outline@latest
    github.com/mailgun/godebug@latest
    github.com/x-motemen/gore/cmd/gore@latest
    github.com/newhook/go-symbols@latest
    github.com/nsf/gocode@latest
    github.com/rogpeppe/godef@latest
    github.com/tools/godep@latest
    github.com/tpng/gopkgs@latest
    golang.org/x/lint/golint@latest
    golang.org/x/tools/gopls@latest
    sourcegraph.com/sqs/goreturns@latest
)

FORMULAS=(
    go
)

h1 "go"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
