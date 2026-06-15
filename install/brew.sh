#!/usr/bin/env bash

source "${BASH_SOURCE%/*}/lib.sh"

h1 "brew"
task "install"
if [ -x "/opt/homebrew/bin/brew" ] || [ -x "/usr/local/bin/brew" ]; then
    warn "installed"
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ $? != 0 ]]; then
        error
        exit 1
    fi
    success
fi

# Load Homebrew into the environment for this script (lib.sh runs this at
# source time too, but brew may have just been installed above).
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    [ -x "$brew_bin" ] && eval "$("$brew_bin" shellenv)" && break
done

task "update"
brew update > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
