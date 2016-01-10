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

.PHONE: help
help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    all       for all of the below\n"
	@printf "    brew      to install Hombrew\n"
	@printf "    util      to install util formulas\n"
	@printf "    install   to symlink dotfiles\n"
	@printf "    clojure   to install clojure leiningen\n"
	@printf "    haskell   to install haskell modules\n"
	@printf "    c         to install c utilities\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    js        to install node modules\n"

all: install brew util go python c haskell js clojure

install: $(DIRS) $(FILES) $(CONFIGS)

.PHONY: $(FILES)
$(FILES):
	@echo "Symlink $@ -> ~/.$@"
	@rm -rf $(HOME)/.$@
	@ln -s $(PWD)/$@ $(HOME)/.$@

.PHONY: $(DIRS)
$(DIRS):
	@echo "Make directory ~/.$@"
	@mkdir -p $(HOME)/.$@

.PHONY: $(CONFIGS)
$(CONFIGS):
	@echo "Symlink $@ -> ~/.config/$@"
	@rm -rf $(HOME)/.config/$@
	@ln -s $(PWD)/$@ $(HOME)/.config/$@

.PHONY: brew
brew:
	$(info Installing Homebrew)
	@sh ./bin/brew.sh

.PHONY: util
util: brew
	$(info Installing formulas)
	@sh ./bin/util.sh

.PHONY: go
go: brew
	$(info Installing go & tools)
	@sh ./bin/go.sh

.PHONY: c
c: brew
	$(info Installing c utilities)
	@sh ./bin/c.sh

.PHONY: haskell
haskell: brew
	$(info Installing haskell & modules)
	@sh ./bin/haskell.sh

.PHONY: clojure
clojure: brew
	$(info Installing clojure)
	@sh ./bin/clojure.sh

.PHONY: js
js: brew
	$(info Installing node & modules)
	@sh ./bin/javascript.sh

.PHONY: python
python: brew
	$(info Installing python & packages)
	@sh ./bin/python.sh
