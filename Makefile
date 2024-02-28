PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

FILES=\
	gitconfig	\
	gitignore	\
	gitmessage	\
	hammerspoon	\
	hushlogin	\
	mackup		\
	mackup.cfg	\
	starship.toml	\
	tmux.conf	\
	wgetrc

MAKEDIRS=\
	$(XDG_CONFIG_HOME)		\
	$(XDG_DATA_HOME)/nvim/backup	\
	$(XDG_DATA_HOME)/nvim/undo

CONFIGS=\
	fish	\
	hack	\
	lf	\
	k9s 	\
	wezterm	\
	nvim


.DEFAULT_GOAL: help
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

dotfiles: $(MAKEDIRS) $(FILES) $(DIRS) $(CONFIGS) terminfo ## symlink dotfiles

base: minimal util devops ## install base setup


.PHONY: $(FILES)
$(FILES):
	$(info Symlink $@ → $(HOME)/.$@)
	@rm -rf $(HOME)/.$@
	@ln -s $(PWD)/$@ $(HOME)/.$@

.PHONY: $(MAKEDIRS)
$(MAKEDIRS):
	$(info Make directory $@)
	@mkdir -p $@

.PHONY: $(CONFIGS)
$(CONFIGS):
	$(info Symlink $@ → $(XDG_CONFIG_HOME)/$@)
	@rm -rf $(XDG_CONFIG_HOME)/$@
	@ln -s $(PWD)/$@ $(XDG_CONFIG_HOME)/$@

.PHONY: terminfo
terminfo: ## install terminfo
	@tic -x -o ~/.terminfo ./terminfo

.PHONY: brew
brew: ## install Homebrew
	@sh ./install/brew.sh

.PHONY: base
minimal: brew dotfiles python ## install minimal setup
	@sh ./install/minimal.sh

.PHONY: util
util: brew ## install utilities
	@sh ./install/util.sh

.PHONY: python
python: brew ## install Python3 toolchain
	@sh ./install/python.sh

.PHONY: go
go: brew ## install Go toolchain
	@sh ./install/go.sh

.PHONY: devops
devops: brew ## install devops toolchain
	@sh ./install/devops.sh

.PHONY: data
data: brew python ## install data science toolchain
	@sh ./install/data.sh
