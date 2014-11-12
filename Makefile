.PHONY: submodules-init submodules-pull uninstall

install: install-zsh install-tmux install-git install-vim install-misc directories submodules-init


install-zsh:
	@rm -rf ~/.zshrc
	@ln -s `pwd`/zsh/zshrc ~/.zshrc
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

directories:
	@mkdir -p ~/.tmp/vim/swaps
	@mkdir -p ~/.tmp/vim/undo
	@mkdir -p ~/.tmp/vim/backup
	@mkdir -p ~/.tmp/zsh/cache
	@echo "Created directories"

submodules-init:
	@git submodule update --init --recursive
	@echo "Initiated submodules"
	
submodules-pull:
	@git submodule foreach git pull origin master
	@echo "Pulled in changes from submodules"

brew-up:
	@sh ./brewfile.sh

uninstall:
	@rm -f ~/.zshrc
	@rm -rf ~/.tmux.conf ~/.tmux
	@rm -f ~/.gitconfig ~/.gitignore-global ~/.gitmessage
	@rm -rf ~/.vimrc ~/.vim
	@rm -f ~/.wgetrc ~/.ackrc ~/.hushlogin
	@echo "Removed linked config"
