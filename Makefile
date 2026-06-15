PWD:=$(shell pwd)

XDG_CONFIG_HOME?=$(HOME)/.config
XDG_DATA_HOME?=$(HOME)/.local/share

# Ensure Homebrew is on PATH for both Apple Silicon (/opt/homebrew) and Intel
# (/usr/local), including right after `make brew` installs it.
export PATH := /opt/homebrew/bin:/usr/local/bin:$(PATH)

FILES=\
	claude		\
	gitconfig	\
	gitignore	\
	gitmessage	\
	hammerspoon	\
	hushlogin	\
	mackup		\
	mackup.cfg	\
	rgignore	\
	ripgreprc	\
	starship.toml	\
	tmux.conf	\
	wgetrc

MAKEDIRS=\
	$(XDG_CONFIG_HOME)		\
	$(XDG_DATA_HOME)/nvim/backup	\
	$(XDG_DATA_HOME)/nvim/undo

CONFIGS=\
	atuin		\
	bat		\
	btop		\
	direnv		\
	fish		\
	harlequin	\
	k9s		\
	kitty		\
	lazydocker	\
	lazygit		\
	navi		\
	nvim		\
	opencode	\
	posting		\
	tmux		\
	wtf		\
	yazi		\
	zk

.DEFAULT_GOAL: help
.PHONY: help
help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "%-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: dotfiles
dotfiles: $(MAKEDIRS) $(FILES) $(DIRS) $(CONFIGS) ## symlink dotfiles

.PHONY: base
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

.PHONY: brew
brew: ## install Homebrew
	@./install/brew.sh

.PHONY: minimal
minimal: brew dotfiles python ## install minimal setup
	brew bundle install --file=install/Brewfile.minimal

.PHONY: util
util: brew ## install utilities
	brew bundle install --file=install/Brewfile.util

.PHONY: qmk
qmk: brew ## install qmk dev chain
	brew bundle install --file=install/Brewfile.qmk

.PHONY: python
python: brew ## install Python3 toolchain
	brew bundle install --file=install/Brewfile.python
	@./install/python.sh

.PHONY: go
go: brew ## install Go toolchain
	brew bundle install --file=install/Brewfile.go
	@./install/go.sh

.PHONY: rust
rust: brew ## install Rust toolchain
	brew bundle install --file=install/Brewfile.rust
	@./install/rust.sh

.PHONY: devops
devops: brew ## install devops toolchain
	brew bundle install --file=install/Brewfile.devops
	@./install/devops.sh

.PHONY: data
data: brew python ## install data science toolchain
	brew bundle install --file=install/Brewfile.data
	@./install/data.sh
