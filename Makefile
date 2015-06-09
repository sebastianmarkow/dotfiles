PWD:=$(shell pwd)

CONFIGDIR:=$(HOME)/.config

CONFIGS:=fish
FILES:=$(filter-out $(CONFIGS), $(wildcard [a-z_.]*))
FOLDER:=tmp/vim/swaps \
       tmp/vim/undo \
       tmp/zsh/cache \
       vim/bundle \
       config

TARGETFOLDER:=$(addprefix $(HOME)/, $(FOLDER:%=.%))
TARGETFILES:=$(addprefix $(HOME)/, $(FILES:%=.%))
TARGETCONFIGS:=$(addprefix $(CONFIGDIR)/, $(CONFIGS))

default: help

all: dotfiles brew go python vimplug

help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    dotfiles  to symlink dotfiles\n"
	@printf "    vimplug   to install vim plugins\n"
	@printf "    brew      to install homebrew & formulas\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    all       for all of the above\n"

dotfiles: $(TARGETFOLDER) $(TARGETFILES) $(TARGETCONFIGS)

$(DOTFOLDER):
	@printf "create $@\n"
	@mkdir -p $@

$(HOME)/.%: $(PWD)/%
	@printf "symlink $< -> $@\n"
	@ln -f -s $< $@

$(CONFIGDIR)/%: $(PWD)/%
	@printf "symlink $< -> $@\n"
	@ln -f -s $< $@

vimplug: dotfiles
	@printf "Installing vimplug\n"
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugUpdate +PlugClean! +qall

brew:
	@printf "Installing brew formulas\n"
	@sh ./Homebrew.sh

go:
	@printf "Installing go tools\n"
	@sh ./Go.sh

python:
	@printf "Installing pip python packages\n"
	@sh ./Python.sh

.PHONY: default dotfiles help vimplug brew go python
