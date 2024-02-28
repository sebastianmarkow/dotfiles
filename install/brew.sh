#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

h1 "brew"
task "install"
if [ -x "/opt/homebrew/bin/brew" ]; then
    warn "installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
        error
        exit 1
    else
        success
    fi
fi

task "update"
brew update > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
