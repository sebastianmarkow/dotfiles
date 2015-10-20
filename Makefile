PWD:=$(shell pwd)

CONFIGDIR:=$(HOME)/.config

CONFIGS:=fish
FILES:=$(filter-out $(CONFIGS), $(wildcard [a-z_.]*))
FOLDER:=cache/vim/swap \
       cache/vim/undo \
       cache/vim/backup \
       vim/bundle \
       config

TARGETFOLDER:=$(addprefix $(HOME)/, $(FOLDER:%=.%))
TARGETFILES:=$(addprefix $(HOME)/, $(FILES:%=.%))
TARGETCONFIGS:=$(addprefix $(CONFIGDIR)/, $(CONFIGS))

default: help

install: dotfiles brew vimplug go python

help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    dotfiles  to symlink dotfiles\n"
	@printf "    vimplug   to install vim plugins\n"
	@printf "    brew      to install homebrew & formulas\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    haskell   to install haskell modules\n"
	@printf "    install   for all of the above\n"

dotfiles: $(TARGETFOLDER) $(TARGETFILES) $(TARGETCONFIGS)

$(TARGETFOLDER):
	$(info create $@)
	@mkdir -p $@

$(HOME)/.%: $(PWD)/%
	$(info Symlink $< -> $@)
	@ln -f -s $< $@

$(CONFIGDIR)/%: $(PWD)/%
	$(info Symlink $< -> $@)
	@ln -f -s $< $@

vimplug: dotfiles
	$(info Installing vimplug & plugins)
	@curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugUpdate +PlugClean! +qall

brew:
	$(info Installing brew formulas)
	@sh ./Homebrew.sh

go: brew
	$(info Installing go tools)
	@sh ./Go.sh

haskell: brew
	$(info Installing haskell modules)
	@sh ./Haskell.sh

python: brew
	$(info Installing python packages)
	@sh ./Python.sh

.PHONY: default dotfiles help vimplug brew go python haskell
