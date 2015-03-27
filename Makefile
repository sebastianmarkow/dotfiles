FILES=zshrc		\
	vimrc		\
	vim		\
	tmux.conf	\
	gitconfig	\
	gitignore	\
	gitmessage	\
	ackrc		\
	wgetrc		\
	hushlogin

DIRS=tmp/vim/swaps	\
	tmp/vim/undo	\
	tmp/vim/backup	\
	tmp/zsh/cache	\
	vim/bundle


default: install

all: brew install go pip vundle

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install   to hook up dotfiles"
	@echo "  vundle    to install vundle - vim plugin manager"
	@echo "  brew      to install homebrew and chosen formulas"
	@echo "  go        to install go tools"
	@echo "  pip       to install python eggs"

install: $(FILES) $(DIRS)

$(FILES):
	@echo "Symlinking $@ -> ~/.$@"
	@rm -rf ~/.$@
	@ln -s $(CURDIR)/$@ ~/.$@

$(DIRS):
	@echo "Making ~/.$@"
	@mkdir -p ~/.$@

vundle: install
	@echo "Installing vundle"
	@test -d ~/.vim/bundle/Vundle.vim || git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall! +qall

brew:
	@echo "Installing brew formulas"
	@./Homebrew.sh

go:
	@echo "Installing go tools"
	@./Go.sh

pip:
	@echo "Installing pip python packages"
	@./Pip.sh

.PHONY: $(FILES) $(DIRS) help
