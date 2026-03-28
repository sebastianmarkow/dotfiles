#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TOOLS=(
    github.com/x-motemen/gore/cmd/gore@latest      # gore - Go REPL
    golang.org/x/tools/gopls@latest                # gopls - Go language server
    github.com/go-delve/delve/cmd/dlv@latest       # Delve - Go debugger
    golang.org/x/tools/cmd/goimports@latest        # goimports - auto-manage imports
    mvdan.cc/gofumpt@latest                        # gofumpt - stricter gofmt
)

FORMULAS=(
    go             # Go - programming language
    golangci-lint  # golangci-lint - meta-linter
)

h1 "go"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
