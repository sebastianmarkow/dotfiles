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


.DEFAULT_GOAL: help
.PHONE: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: brew
brew:
	$(info Install Homebrew)
	@sh ./install/brew.sh

dot: $(DIRS) $(FILES) $(CONFIGS) ## Symlink dotfiles

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

.PHONY: util
util: brew ## Install utility
	$(info Install utility)
	@sh ./install/util.sh

.PHONY: go
go: brew ## Install Go
	$(info Install Go & toolchain)
	@sh ./install/go.sh

.PHONY: cxx
cxx: brew ## Install CXX toolchain
	$(info Install CXX toolchain)
	@sh ./install/cxx.sh

.PHONY: rust
rust: brew ## Install Rust
	$(info Installing Rust & toolchain)
	@sh ./install/rust.sh

.PHONY: python
python: brew ## Install Python3
	$(info Installing Python3 & toolchain)
	@sh ./install/python.sh

.PHONY: js
js: brew ## Install Node
	$(info Installing Node & toolchain)
	@sh ./install/js.sh

.PHONY: data
data: brew python ## Install datascience toolchain
	$(info Installing datascience toolchain)
	@sh ./install/data.sh
