PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

FILES=tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	hammerspoon

DIRS=$(XDG_CONFIG_HOME) \
	$(XDG_DATA_HOME)/nvim/undo	\
	$(XDG_DATA_HOME)/nvim/backup

CONFIGS=fish	\
	nvim \
	lf


.DEFAULT_GOAL: help
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

dotfiles: $(DIRS) $(FILES) $(CONFIGS) ## symlink dotfiles

base: minimal util ## install base setup

.PHONY: $(DIRS)
$(DIRS):
	$(info Make directory $@)
	@mkdir -p $@

.PHONY: $(FILES)
$(FILES):
	$(info Symlink $@ → $(HOME)/.$@)
	@rm -rf $(HOME)/.$@
	@ln -s $(PWD)/$@ $(HOME)/.$@

.PHONY: $(CONFIGS)
$(CONFIGS):
	$(info Symlink $@ → $(XDG_CONFIG_HOME)/$@)
	@rm -rf $(XDG_CONFIG_HOME)/$@
	@ln -s $(PWD)/$@ $(XDG_CONFIG_HOME)/$@

.PHONY: base
minimal: brew dotfiles ## install minimal setup
	@sh ./install/minimal.sh

.PHONY: brew
brew: ## install Homebrew
	@sh ./install/brew.sh

.PHONY: cxx
cxx: brew ## install C/C++ toolchain
	@sh ./install/cxx.sh

.PHONY: devops
devops: brew ## install devops toolchain
	@sh ./install/devops.sh

.PHONY: data
data: brew python ## install data science toolchain
	@sh ./install/data.sh

.PHONY: go
go: brew ## install Go toolchain
	@sh ./install/go.sh

.PHONY: python
python: brew ## install Python3 toolchain
	@sh ./install/python.sh

.PHONY: rust
rust: brew ## install Rust toolchain
	@sh ./install/rust.sh

.PHONY: util
util: brew ## install utilities
	@sh ./install/util.sh
