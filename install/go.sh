#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/lib.sh"

# Homebrew formulas live in install/Brewfile.go (go, golangci-lint).

TOOLS=(
    github.com/x-motemen/gore/cmd/gore@latest      # gore - Go REPL
    golang.org/x/tools/gopls@latest                # gopls - Go language server
    github.com/go-delve/delve/cmd/dlv@latest       # Delve - Go debugger
    golang.org/x/tools/cmd/goimports@latest        # goimports - auto-manage imports
    mvdan.cc/gofumpt@latest                        # gofumpt - stricter gofmt
)

h1 "go"
h2 "go tools"
for t in "${TOOLS[@]}"; do go_get "$t"; done
