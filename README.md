# 💥🔫 dotdotdotdotdotfiles

A heavily opinionated set of dotfiles (git, vim, zsh & tmux).

## Requirements

* `make`
* `git`

## Installation

    $ git clone https://github.com/sebastianmarkow/dotfiles.git
    $ cd dotfiles && make
    Please use `make <target>' where <target> is one of
        dotfiles  to symlink dotfiles
        vundle    to install vim vundle
        brew      to install homebrew & formulas
        goget     to install go tools
        all       for all of the above

**Warning:** Please backup any current dotfiles in your users home directory before running any `make` target. Files will be overwritten.
