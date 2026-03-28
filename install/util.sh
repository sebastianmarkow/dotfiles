#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

TAPS=(
    go-task/tap
    homebrew/cask
    homebrew/core
)

FORMULAS=(
    ast-grep            # ast-grep - structural code search via AST patterns
    bat                 # bat - cat replacement with syntax highlighting
    calc                # calc - arbitrary-precision calculator
    cloc                # cloc - count lines of code
    cloog               # CLooG - polyhedral code generator
    entr                # entr - run commands on file change
    fdupes              # fdupes - find duplicate files
    fx                  # fx - interactive JSON viewer
    glow                # Glow - markdown renderer with pager
    go-task             # Task - Makefile alternative
    graphviz            # Graphviz - graph visualization
    gum                 # gum - shell script UI components
    harlequin           # Harlequin - TUI SQL IDE
    hurl                # Hurl - scriptable HTTP request runner
    hyperfine           # Hyperfine - statistical CLI benchmarking
    jless               # jless - TUI pager for JSON navigation
    jo                  # jo - JSON output from shell
    lua                 # Lua - scripting language
    luajit              # LuaJIT - JIT compiler for Lua
    mandoc              # mandoc - man page renderer
    navi                # navi - interactive cheatsheet with fzf
    posting             # Posting - TUI HTTP client
    pv                  # pv - monitor pipe data progress
    ragel               # Ragel - state machine compiler
    rclone              # rclone - cloud storage sync
    serpl               # serpl - TUI find-and-replace across files
    shellcheck          # ShellCheck - shell script linter
    terminal-notifier   # terminal-notifier - macOS notifications from CLI
    trash               # trash - safe delete (moves to Trash)
    upx                 # UPX - executable compressor
    vmtouch             # vmtouch - manage filesystem cache
    w3m                 # w3m - terminal web browser
    xh                  # xh - httpie-compatible HTTP client
    yank                # yank - copy terminal output to clipboard
)

CASKS=(
    arq             # Arq - backup software
    alfred          # Alfred - macOS launcher and productivity
    aerial          # Aerial - Apple TV screensavers
    hazel           # Hazel - automated file organizer
    monitorcontrol  # MonitorControl - external display brightness/volume
)

h1 "utilities"
h2 "brew taps"
for t in "${TAPS[@]}"; do brew_tap "$t"; done
h2 "brew casks"
for f in "${CASKS[@]}"; do cask_install "$f"; done
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
