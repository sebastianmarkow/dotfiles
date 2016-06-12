#!/usr/bin/env bash

set -e

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

h1 "brew"
task "install"
if [ -x "/usr/local/bin/brew" ]; then
    warn "installed"
else
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    if [[ $? != 0 ]]; then
        error
        exit 1
    else
        success
    fi
fi
