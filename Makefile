PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

FILES=tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	npmrc

DIRS=$(XDG_CONFIG_HOME) \
	$(XDG_DATA_HOME)/nvim/undo	\
	$(XDG_DATA_HOME)/nvim/backup

CONFIGS=fish	\
	nvim


default: help

.PHONE: help
help:
	@printf "Please use \`make <target>' where <target> is one of\n"
	@printf "    all       for all of the below\n"
	@printf "    brew      to install Hombrew\n"
	@printf "    util      to install util formulas\n"
	@printf "    install   to symlink dotfiles\n"
	@printf "    clojure   to install clojure leiningen\n"
	@printf "    c         to install c utilities\n"
	@printf "    python    to install python packages\n"
	@printf "    go        to install go tools\n"
	@printf "    js        to install node modules\n"

all: install brew util go python c haskell js clojure

install: $(DIRS) $(FILES) $(CONFIGS)

.PHONY: $(DIRS)
$(DIRS):
	$(info Make directory $@)
	@mkdir -p $@

.PHONY: $(FILES)
$(FILES):
	$(info Symlink $@ -> $(HOME)/.$@)
	@rm -rf $(HOME)/.$@
	@ln -s $(PWD)/$@ $(HOME)/.$@

.PHONY: $(CONFIGS)
$(CONFIGS):
	$(info Symlink $@ -> $(XDG_CONFIG_HOME)/$@)
	@rm -rf $(XDG_CONFIG_HOME)/$@
	@ln -s $(PWD)/$@ $(XDG_CONFIG_HOME)/$@

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
