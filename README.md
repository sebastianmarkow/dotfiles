dotfiles
========

A heavily opinionated set of dotfiles for macOS/darwin.

Includes configs for: fish, neovim, kitty, tmux, lazygit, yazi, starship, opencode, and more.

Requirements
------------

* `make`
* `bash`
* `brew`

Usage
-----

~~~
$ git clone https://github.com/sebastianmarkow/dotfiles.git
$ cd dotfiles
$ make help
~~~

**Warning:** `make dotfiles` will overwrite existing files in `$HOME`. Back up anything you want to keep first.

Install Targets
---------------

| Target    | Description                        |
|-----------|------------------------------------|
| `dotfiles` | Symlink all dotfiles               |
| `base`    | Install base setup (minimal+devops) |
| `minimal` | Homebrew + dotfiles + Python       |
| `util`    | Utilities via Homebrew             |
| `python`  | Python3 toolchain                  |
| `go`      | Go toolchain                       |
| `rust`    | Rust toolchain                     |
| `devops`  | DevOps toolchain                   |
| `qmk`     | QMK keyboard firmware dev chain    |
