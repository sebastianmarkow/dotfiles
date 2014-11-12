.PHONY: uninstall

install: uninstall install-zsh install-tmux install-git install-vim install-misc directories


install-zsh:
	@ln -s `pwd`/zsh/zshrc ~/.zshrc
	@echo "Symlinked zsh config"

install-tmux:
	@ln -s `pwd`/tmux ~/.tmux
	@ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf
	@echo "Symlinked tmux config"

install-git:
	@ln -s `pwd`/git/gitconfig ~/.gitconfig
	@ln -s `pwd`/git/gitignore-global ~/.gitignore-global
	@echo "Symlinked git config"

install-vim:
	@ln -s `pwd`/vim ~/.vim
	@ln -s `pwd`/vim/vimrc ~/.vimrc
	@echo "Symlinked vim config"

install-misc:
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

brew-up:
	@sh ./brewfile.sh

uninstall:
	@rm -f ~/.zshrc
	@rm -rf ~/.tmux.conf ~/.tmux
	@rm -f ~/.gitconfig ~/.gitignore-global
	@rm -rf ~/.vimrc ~/.vim
	@rm -f ~/.wgetrc ~/.ackrc ~/.hushlogin
	@echo "Removed linked config"
