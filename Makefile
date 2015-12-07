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
	@printf "    base      for dotfiles/homebrew\n"
	@printf "    install   to symlink dotfiles\n"
	@printf "    brew      to install homebrew & formulas\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    js        to install node modules\n"
	@printf "    haskell   to install haskell modules\n"

base: install brew

all: base go python haskell js

install: $(DIRS) $(FILES) $(CONFIGS)

$(FILES):
	@echo "Symlink $@ -> ~/.$@"
	@rm -rf $(HOME)/.$@ 
	@ln -s $(PWD)/$@ $(HOME)/.$@

$(DIRS):
	@echo "Make directory ~/.$@"
	@mkdir -p $(HOME)/.$@

$(CONFIGS):
	@echo "Symlink $@ -> ~/.config/$@"
	@rm -rf $(HOME)/.config/$@ 
	@ln -s $(PWD)/$@ $(HOME)/.config/$@

brew:
	$(info Installing brew & formulas)
	@sh ./Homebrew.sh

go: brew
	$(info Installing go & tools)
	@sh ./Go.sh

haskell: brew
	$(info Installing haskell & modules)
	@sh ./Haskell.sh

js: brew
	$(info Installing node & modules)
	@sh ./Javascript.sh

python: brew
	$(info Installing python & packages)
	@sh ./Python.sh

.PHONY: default $(FILES) $(DIRS) $(CONFIGS) install help brew go python haskell js
