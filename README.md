# 💥🔫 dotdotdotdotdotfiles

A heavily opinionated set of dotfiles (git, vim, fish & tmux).

## Requirements

* `make`

## Installation

    $ git clone https://github.com/sebastianmarkow/dotfiles.git
    $ cd dotfiles && make
    Please use `make <target>' where <target> is one of
        all       for all of the below
        base      for dotfiles/homebrew
        install   to symlink dotfiles
        brew      to install homebrew & formulas
        python    to install python packages
        go        to install go tools
        js        to install node modules
        haskell   to install haskell modules

**Warning:** Existing dotfiles in `$HOME`will be overwritten.
