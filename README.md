# dotfiles

## Requirements

Required:

- `make`

Optional:

- `ruby` (Homebrew)

## Installation

just run:

    $ git clone https://github.com/sebastianmarkow/dotfiles.git ~/.dotfiles && cd ~/.dotfiles && make

Note: **Please backup your existing dotfiles in `~/` before running `make`**

## Update/Upgrade submodules

`cd` into your local `dotfiles` copy and

    $ make update

or

    $ make upgrade

and commit any changes within submodules.

## Homebrew (OSX)

Install `brew` and boot `Brewfile`

    $ make brew

## Uninstall

    $ make uninstall
