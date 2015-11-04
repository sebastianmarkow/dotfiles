PWD:=$(shell pwd)

FILES=vim		\
	tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	ghci

DIRS=cache/vim/swap		\
	cache/vim/undo		\
	cache/vim/backup	\
	config


CONFIGS=fish


default: help

install: dotfiles brew go python

help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    dotfiles  to symlink dotfiles\n"
	@printf "    brew      to install homebrew & formulas\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    haskell   to install haskell modules\n"
	@printf "    install   for all of the above\n"

dotfiles: $(DIRS) $(FILES) $(CONFIGS)

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

go: brew
	$(info Installing go tools)
	@sh ./Go.sh

haskell: brew
	$(info Installing haskell modules)
	@sh ./Haskell.sh

python: brew
	$(info Installing python packages)
	@sh ./Python.sh

.PHONY: default $(FILES) $(DIRS) $(CONFIGS) dotfiles help vimplug brew go python haskell
