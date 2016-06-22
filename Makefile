PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

FILES=tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	wgetrc		\
	hushlogin

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
	@sh ./install/brew.sh

all: dotfiles cxx data go python rust util ## all of the below

dotfiles: $(DIRS) $(FILES) $(CONFIGS) ## symlink dotfiles

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

.PHONY: cxx
cxx: brew ## install cxx toolchain
	@sh ./install/cxx.sh

.PHONY: data
data: brew python ## install data science toolchain
	@sh ./install/data.sh

.PHONY: go
go: brew ## install Go
	@sh ./install/go.sh

.PHONY: python
python: brew ## install Python3
	@sh ./install/python.sh

.PHONY: rust
rust: brew ## install Rust
	@sh ./install/rust.sh

.PHONY: util
util: brew ## install utilities
	@sh ./install/util.sh
