PWD:=$(shell pwd)

FILES=vim		\
	tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	ghci

DIRS=cache/vim     		\
	cache/vim/undo		\
	cache/vim/backup	\
	config

CONFIGS=fish


default: help

help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    all       for all of the below\n"
	@printf "    install   to symlink dotfiles\n"
	@printf "    brew      to install homebrew & formulas\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    haskell   to install haskell modules\n"

all: install brew go python

install: $(DIRS) $(FILES) $(CONFIGS)

$(FILES):
	@echo "Symlinking $@ -> ~/.$@"
	@rm -rf $(HOME)/.$@ 
	@ln -s $(PWD)/$@ $(HOME)/.$@

$(DIRS):
	@echo "Making ~/.$@"
	@mkdir -p $(HOME)/.$@

$(CONFIGS):
	@echo "Symlinking $@ -> ~/.config/$@"
	@rm -rf $(HOME)/.config/$@ 
	@ln -s $(PWD)/$@ $(HOME)/.config/$@

brew:
	$(info Installing brew formulas)
	@sh ./Homebrew.sh

go:
	$(info Installing go tools)
	@sh ./Go.sh

haskell:
	$(info Installing haskell modules)
	@sh ./Haskell.sh

python:
	$(info Installing python packages)
	@sh ./Python.sh

.PHONY: default $(FILES) $(DIRS) $(CONFIGS) install help brew go python haskell
