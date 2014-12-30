.PHONY: help uninstall

help:
	@echo "Please use \`make <target>' where <target> is one of"
	@echo "  install   to hook up dotfiles"
	@echo "  uninstall to remove dotfiles"
	@echo "  brew      to install homebrew and chosen formulas"

install: uninstall directories install-misc install-zsh install-tmux install-git install-vim install-vundle

install-zsh:
	@ln -s `pwd`/zshrc ~/.zshrc
	@echo "Symlinked zsh config"

install-tmux:
	@ln -s `pwd`/tmux.conf ~/.tmux.conf
	@echo "Symlinked tmux config"

install-git:
	@ln -s `pwd`/gitconfig ~/.gitconfig
	@ln -s `pwd`/gitignore ~/.gitignore
	@echo "Symlinked git config"

install-vim:
	@ln -s `pwd`/vim ~/.vim
	@ln -s `pwd`/vimrc ~/.vimrc
	@echo "Symlinked vim config"

install-vundle:
	@mkdir -p ~/.vim/bundle/
	@echo "Cloning vundle plugin manager"
	@git clone -q https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
	@vim +PluginInstall +qall
	@echo "Installed vundle"

install-misc:
	@ln -s `pwd`/wgetrc ~/.wgetrc
	@ln -s `pwd`/ackrc ~/.ackrc
	@touch ~/.hushlogin
	@echo "Symlinked misc config"

directories:
	@mkdir -p ~/.tmp/vim/swaps
	@mkdir -p ~/.tmp/vim/undo
	@mkdir -p ~/.tmp/vim/backup
	@mkdir -p ~/.tmp/zsh/cache
	@echo "Created directories"

brew:
	@sh ./bin/brewfile.sh

uninstall:
	@rm -f ~/.zshrc
	@rm -rf ~/.tmux.conf ~/.tmux
	@rm -f ~/.gitconfig ~/.gitignore
	@rm -rf ~/.vimrc ~/.vim/bundle/ ~/.vim
	@rm -f ~/.wgetrc ~/.ackrc ~/.hushlogin
	@echo "Removed linked config"
