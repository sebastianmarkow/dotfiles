PWD:=$(shell pwd)

FILES=vim		\
	tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	ghci            \
	npmrc

DIRS=cache/vim     		\
	cache/vim/undo		\
	cache/vim/backup	\
	config

CONFIGS=fish


default: help

help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    all       for all of the below\n"
	@printf "    brew      to install Hombrew\n"
	@printf "    util      to install util formulas\n"
	@printf "    install   to symlink dotfiles\n"
	@printf "    clojure   to install clojure leiningen\n"
	@printf "    haskell   to install haskell modules\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    js        to install node modules\n"

base: install brew util

all: install brew util go python haskell js clojure

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
	$(info Installing Homebrew)
	@sh ./bin/brew.sh

util: brew
	$(info Installing formulas)
	@sh ./bin/util.sh

go: brew
	$(info Installing go & tools)
	@sh ./bin/go.sh

haskell: brew
	$(info Installing haskell & modules)
	@sh ./bin/haskell.sh

clojure: brew
	$(info Installing clojure)
	@sh ./bin/clojure.sh

js: brew
	$(info Installing node & modules)
	@sh ./bin/javascript.sh

python: brew
	$(info Installing python & packages)
	@sh ./bin/python.sh

.PHONY: default $(FILES) $(DIRS) $(CONFIGS) install help brew go python haskell js
