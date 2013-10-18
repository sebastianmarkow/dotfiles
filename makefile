install: install-zsh install-tmux install-git install-hg install-vim \
	install-irssi update-submodules

update: update-submodules

upgrade: upgrade-submodules

uninstall:
	@echo "Unlinking files"
	rm -f ~/.zshrc
	rm -rf ~/.tmux.conf ~/.tmux
	rm -f ~/.gitconfig ~/.gitignore-global
	rm -f ~/.hgignore_global ~/.hgrc
	rm -rf ~/.vimrc ~/.vim
	rm -rf ~/.irssi


# ------------------------------------------------------------------------------
# CONFIG
# ------------------------------------------------------------------------------

install-zsh:
	@echo "Symlinking zsh"
	rm -rf ~/.zshrc
	ln -s `pwd`/zsh/zshrc ~/.zshrc

install-tmux:
	@echo "Symlinking tmux"
	rm -rf ~/.tmux ~/.tmux.conf
	ln -s `pwd`/tmux ~/.tmux
	ln -s `pwd`/tmux/tmux.conf ~/.tmux.conf

install-git:
	@echo "Symlinking git"
	rm -f ~/.gitconfig ~/.gitignore-global
	ln -s `pwd`/git/gitconfig ~/.gitconfig
	ln -s `pwd`/git/gitignore-global ~/.gitignore-global

install-hg:
	@echo "Symlinking hg"
	rm -f ~/.hgignore_global ~/.hgrc
	ln -s `pwd`/hg/hgrc ~/.hgrc
	ln -s `pwd`/hg/hgignore_global ~/.hgignore_global

install-vim:
	@echo "Symlinking vim"
	rm -rf ~/.vim ~/.vimrc
	ln -s `pwd`/vim ~/.vim
	ln -s `pwd`/vim/vimrc ~/.vimrc

install-irssi:
	@echo "Symlinking irssi"
	rm -rf ~/.irssi
	ln -s `pwd`/irssi ~/.irssi


# ------------------------------------------------------------------------------
# SUBMODULE
# ------------------------------------------------------------------------------

update-submodules:
	@echo "Updating git-submodules"
	git submodule update --init
	
upgrade-submodules:
	@echo "Upgrading git-submodules"
	git submodule foreach git pull origin master

