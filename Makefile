.PHONY: init-submodules pull-submodules uninstall source-zsh

install: install-zsh install-tmux install-git install-vim install-misc make-temp-dir init-submodules source-zsh


install-zsh:
	@rm -rf ~/.zshrc ~/.zshenv
	@ln -s `pwd`/zsh/zshrc ~/.zshrc
	@ln -s `pwd`/zsh/zshenv ~/.zshenv
	@echo "Symlinked zsh config"

install-tmux:
	@rm -rf ~/.tmux ~/.tmux.conf
	@ln -s `pwd`/tmux ~/.tmux
	@ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
	@echo "Symlinked tmux config"

install-git:
	@rm -f ~/.gitconfig ~/.gitignore-global ~/.gitmessage
	@ln -s `pwd`/git/gitconfig ~/.gitconfig
	@ln -s `pwd`/git/gitignore-global ~/.gitignore-global
	@ln -s `pwd`/git/gitmessage ~/.gitmessage
	@echo "Symlinked git config"

install-vim:
	@rm -rf ~/.vim ~/.vimrc
	@ln -s `pwd`/vim ~/.vim
	@ln -s `pwd`/vim/vimrc ~/.vimrc
	@echo "Symlinked vim config"

install-misc:
	@rm -rf ~/.wgetrc ~/.ackrc ~/.hushlogin
	@ln -s `pwd`/misc/wgetrc ~/.wgetrc
	@ln -s `pwd`/misc/ackrc ~/.ackrc
	@ln -s `pwd`/misc/hushlogin ~/.hushlogin
	@echo "Symlinked misc config"

make-temp-dir:
	@mkdir -p ~/.tmp/vim
	@mkdir -p ~/.tmp/vim/undo
	@mkdir -p ~/.tmp/vim/backup
	@mkdir -p ~/.tmp/zsh/cache
	@echo "Created temp directories"

source-zsh:
	@source ~/.zshenv
	@echo "Sourced zsh env"

init-submodules:
	@echo "Initiating submodules"
	@git submodule update --init --recursive
	
pull-submodules:
	@echo "Pulling in changes from submodules"
	@git submodule foreach git pull origin master

uninstall:
	@rm -f ~/.zshrc
	@rm -rf ~/.tmux.conf ~/.tmux
	@rm -f ~/.gitconfig ~/.gitignore-global ~/.gitmessage
	@rm -rf ~/.vimrc ~/.vim
	@rm -f ~/.wgetrc ~/.ackrc ~/.hushlogin
	@echo "Removed linked config"
