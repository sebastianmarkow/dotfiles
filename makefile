install: install-zsh install-tmux install-git install-hg install-vim install-misc init-submodules

update: update-submodules

uninstall:
	@echo "Unlinking files"
	rm -f ~/.zshrc
	rm -rf ~/.tmux.conf ~/.tmux
	rm -f ~/.gitconfig ~/.gitignore-global
	rm -f ~/.hgignore_global ~/.hgrc
	rm -rf ~/.vimrc ~/.vim
	rm -rf ~/.wgetrc

install-zsh:
	@echo "Symlinking zsh"
	rm -rf ~/.zshrc
	ln -sf `pwd`/zsh/zshrc ~/.zshrc

install-tmux:
	@echo "Symlinking tmux"
	rm -rf ~/.tmux ~/.tmux.conf
	ln -sf `pwd`/tmux ~/.tmux
	ln -sf `pwd`/tmux/tmux.conf ~/.tmux.conf

install-git:
	@echo "Symlinking git"
	rm -f ~/.gitconfig ~/.gitignore-global
	ln -sf `pwd`/git/gitconfig ~/.gitconfig
	ln -sf `pwd`/git/gitignore-global ~/.gitignore-global

install-hg:
	@echo "Symlinking hg"
	rm -f ~/.hgignore_global ~/.hgrc
	ln -sf `pwd`/hg/hgrc ~/.hgrc
	ln -sf `pwd`/hg/hgignore_global ~/.hgignore_global

install-vim:
	@echo "Symlinking vim"
	rm -rf ~/.vim ~/.vimrc
	ln -sf `pwd`/vim ~/.vim
	ln -sf `pwd`/vim/vimrc ~/.vimrc

install-misc:
	@echo "Symlinking misc"
	rm -f ~/.wgetrc
	ln -sf `pwd`/wget/wgetrc ~/.wgetrc

install-brew:
	@echo "Installing brew"
	ruby -e `curl -fsSL https://raw.github.com/mxcl/homebrew/go`

init-submodules:
	@echo "Initiating git-submodules"
	git submodule update --init

update-submodules:
	@echo "Updating git-submodules"
	git submodule foreach git pull origin master
