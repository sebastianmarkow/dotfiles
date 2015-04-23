set -x PATH /usr/local/bin /usr/local/sbin $PATH


set -x EDITOR vim
set -x VISUAL $EDITOR
set -x PAGER less
set -x LESS "--ignore-case --chop-long-lines --long-prompt --silent"

# go
set -x GOPATH $HOME/go
set -x GOBIN $GOPATH/bin
set -x PATH $GOBIN $PATH
set -x PATH /usr/local/Cellar/go/1.4.2/libexec/bin $PATH

set -x LANG=en_US.UTF-8

# node
set -x PATH (brew --prefix node)/bin $PATH

# python
# set -x PIP_REQUIRE_VIRTUALENV true
set -x VIRTUALFISH_COMPAT_ALIASES true
eval (python3.4 -m virtualfish)

set -e fish_greeting

