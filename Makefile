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


default: help

all: dotfiles brew go python vimplug

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "    dotfiles  to symlink dotfiles"
	@echo "    vimplug   to install vim plugins"
	@echo "    brew      to install homebrew & formulas"
	@echo "    python    to install python packages"
	@echo "    go        to install go tools"
	@echo "    all       for all of the above"

dotfiles: $(FILES) $(DIRS)

$(FILES):
	@echo "Symlinking $@ -> ~/.$@"
	@rm -rf ~/.$@
	@ln -s $(CURDIR)/$@ ~/.$@

$(DIRS):
	@echo "Making ~/.$@"
	@mkdir -p ~/.$@

vimplug: brew dotfiles
	@echo "Installing vimplug"
	@curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@vim +PlugUpdate +qall

brew:
	@echo "Installing brew formulas"
	@./Homebrew.sh

go: brew
	@echo "Installing go tools"
	@./Go.sh

python: brew
	@echo "Installing pip python packages"
	@./Python.sh

.PHONY: $(FILES) $(DIRS) help
