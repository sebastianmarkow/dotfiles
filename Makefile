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

dotfiles: $(DIRS) $(FILES) $(CONFIGS) ## Symlink dotfiles to user $HOME

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
brew: ## Install Homebrew
	$(info Install Homebrew)
	@sh ./bin/brew.sh

.PHONY: util
util: brew ## Install util formulas
	$(info Install util formulas)
	@sh ./bin/util.sh

.PHONY: go
go: brew ## Install go and development toolchain
	$(info Install go and toolchain)
	@sh ./bin/go.sh

.PHONY: cxx
cxx: brew ## Install cxx development toolchain
	$(info Install cxx toolchain)
	@sh ./bin/cxx.sh

.PHONY: rust
rust: brew ## Install rust and development toolchain
	$(info Installing rust and toolchain)
	@sh ./bin/rust.sh

.PHONY: python
python: brew ## Install python3 and utility packages
	$(info Installing python3 and packages)
	@sh ./bin/python.sh

.PHONY: datascience
datascience: brew ## Install datascience toolchain
	$(info Installing datascience toolchain)
	@sh ./bin/datascience.sh

.PHONY: javascript
javascript: brew ## Install node and development toolchain
	$(info Installing node and toolchain)
	@sh ./bin/javascript.sh
