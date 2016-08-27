#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

h1 "cask"
task "install"
cask=$(brew tap | grep "caskroom/cask")
if [ -n "$cask" ]; then
    warn "installed"
else
    brew tap "caskroom/cask" > /dev/null 2>&1
    if [[ $? != 0 ]]; then
        error
        exit 1
    else
        success
    fi
fi

task "update"
brew cask update > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
