#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TOOLS=(
    github.com/x-motemen/gore/cmd/gore@latest
    golang.org/x/tools/gopls@latest
    github.com/go-delve/delve/cmd/dlv@latest    # debugger (replaces godebug)
    golang.org/x/tools/cmd/goimports@latest     # auto-manage imports (replaces goreturns)
    mvdan.cc/gofumpt@latest                     # stricter gofmt
)

FORMULAS=(
    go
    golangci-lint # meta-linter (replaces golint)
)

h1 "go"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
