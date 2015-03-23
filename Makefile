CURDIR?= $(.CURDIR)
TEMPDIR=~/.tmp

FILES=zshrc		\
	vimrc		\
	vim		\
	tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage      \
	ackrc		\
	wgetrc		\
	hushlogin

TEMPDIRS=vim/swaps	\
	vim/undo	\
	vim/backup	\
	zsh/cache

.PHONY: $(FILES) $(TEMPDIRS) help

default: install

all: install brew vundle go pip

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install   to hook up dotfiles"
	@echo "  vundle    to install vundle - vim plugin manager"
	@echo "  brew      to install homebrew and chosen formulas"
	@echo "  go        to install go tools"
	@echo "  pip       to install python eggs"

install: $(FILES) $(TEMPDIRS)

$(FILES):
	@echo "Symlinking $@"
	@rm -rf ~/.$@
	@ln -s $(CURDIR)/$@ ~/.$@

$(TEMPDIRS):
	@echo "Making $@"
	@mkdir -p $(TEMPDIR)/$@

vundle:
	@echo "Installing vundle"
	@rm -rf ~/.vim/bundle
	@mkdir -p ~/.vim/bundle
	@git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall

brew:
	@echo "Installing brew formulas"
	@./Homebrew.sh

go:
	@echo "Installing go tools"
	@./Go.sh

pip:
	@echo "Installing python eggs"
	@./Pip.sh
