# 💥🔫 dotdotdotdotdotfiles

A heavily opinionated set of dotfiles (git, vim, fish & tmux).

## Requirements

* `make`

## Installation

    $ git clone https://github.com/sebastianmarkow/dotfiles.git
    $ cd dotfiles && make
    Please use \`make <target>' where <target> is one of
        dotfiles  to symlink dotfiles
        vimplug   to install vim plugins
        brew      to install homebrew & formulas
        python    to install python packages
        go        to install go tools
        all       for all of the above

**Notice:**
Existing dotfiles will not be overwritten.
Files won't be linked if there's already a corresponding `.file` in your home directory.
