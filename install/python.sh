#!/usr/bin/env bash

PATH=/usr/local/bin:$PATH

source "${BASH_SOURCE%/*}/lib.sh"

EGGS=(
    black
    mypy-lang
    pep8
    pip-review
    poetry
    pyannotate
    pyflakes
    pylint
    pyls-black
    python-language-server
)

FORMULAS=(
    pyenv
)

PYTHONENVS=(
    3.8.16
    3.10.10
)

PYTHONENVGLOBAL=3.8.16

h1 "python"
h2 "brew formulas"
for f in "${FORMULAS[@]}"; do brew_install "$f"; done
h2 "pyenv environments"
for f in "${PYTHONENVS[@]}"; do pyenv_install "$f"; done
h2 "set global pyenv environemnt"
task "to $PYTHONENVGLOBAL"
pyenv global "$PYTHONENVGLOBAL" > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
h2 "pip modules"
task "update pip"
pip3 install --upgrade -qqq pip > /dev/null 2>&1
if [[ $? != 0 ]]; then
    error
    exit 1
else
    success
fi
for e in "${EGGS[@]}"; do pip_install "$e"; done
