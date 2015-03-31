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

all: dotfiles brew go python vundle

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "    dotfiles  to symlink dotfiles"
	@echo "    vundle    to install vim vundle"
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

vundle: brew dotfiles
	@echo "Installing vundle"
	@test -d ~/.vim/bundle/Vundle.vim || git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall! +qall

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
