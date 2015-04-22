PWD:=$(shell pwd)

SOURCES:=$(wildcard [a-z_.]*!.fish) config/fish/config.fish
FOLDER:=tmp/vim/swaps \
       tmp/vim/undo \
       tmp/zsh/cache \
       vim/bundle \
       config/fish \

DOTFOLDER:=$(addprefix $(HOME)/, $(FOLDER:%=.%))
DOTFILES:=$(addprefix $(HOME)/, $(SOURCES:%=.%))

default: help

all: dotfiles brew go python vimplug

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "    dotfiles  to symlink dotfiles"
	@echo "    vimplug   to install vim plugins"
	@echo "    brew      to install homebrew & formulas"
	@echo "    python    to install python packages"
	@echo "    go        to install go tools"
	@echo "    all       for all of the above"

dotfiles: $(DOTFOLDER) $(DOTFILES)

$(DOTFOLDER):
	@echo "create $@"
	@mkdir -p $@

$(HOME)/.%: $(PWD)/%
	@echo "symlink $< -> $@"
	@ln -f -s $< $@

$(HOME)/.config/fish/config.fish: $(PWD)/config.fish
	@echo "symlink $< -> $@"
	@ln -f -s $< $@

vimplug: dotfiles
	@echo "Installing vimplug"
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugUpdate +PlugClean! +qall

brew:
	@echo "Installing brew formulas"
	@./Homebrew.sh

go: brew
	@echo "Installing go tools"
	@./Go.sh

python: brew
	@echo "Installing pip python packages"
	@./Python.sh

.PHONY: default dotfiles help vimplug brew go python
