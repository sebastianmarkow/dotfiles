PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

FILES=tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin	\
	npmrc           \
	irssi

DIRS=$(XDG_CONFIG_HOME) \
	$(XDG_DATA_HOME)/nvim/undo	\
	$(XDG_DATA_HOME)/nvim/backup

CONFIGS=fish	\
	nvim


.DEFAULT_GOAL: help
.PHONE: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)


base: dotfiles util python ## Run `dotfiles`, `util` and `python` targets

dotfiles: $(DIRS) $(FILES) $(CONFIGS) ## Symlink dotfiles into current user $HOME

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
	$(info Installing Homebrew)
	@sh ./bin/brew.sh

.PHONY: util
util: brew ## Install cli utilities
	$(info Installing formulas)
	@sh ./bin/util.sh

.PHONY: go
go: brew ## Install go and development toolchain
	$(info Installing go & tools)
	@sh ./bin/go.sh

.PHONY: c
c: brew ## Install c development toolchain
	$(info Installing c utilities)
	@sh ./bin/c.sh

.PHONY: rust
rust: brew ## Install rust and development toolchain
	$(info Installing rust)
	@sh ./bin/rust.sh

.PHONY: python
python: brew ## Install python3 and utility packages
	$(info Installing python & packages)
	@sh ./bin/python.sh

.PHONY: datascience
datascience: brew ## Install python datascience packages
	$(info Installing python datascience packages)
	@sh ./bin/datascience.sh

.PHONY: js
js: brew ## Install node and development toolchain
	$(info Installing node & modules)
	@sh ./bin/javascript.sh
