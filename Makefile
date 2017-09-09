.PHONY: all install clean

.ONESHELL:
SHELL = /bin/bash
setup-ubuntu:
	if python -mplatform | grep -qi Ubuntu; then
		echo "Setting up for Ubuntu via apt-get..."
		sudo add-apt-repository ppa:neovim-ppa/stable
		sudo apt-get update
		sudo apt-get install software-properties-common python-dev \
			python-pip python3-dev python3-pip cmake python-pygments \
			neovim cargo zsh
		sudo cargo install ripgrep
	fi

.ONESHELL:
SHELL = /bin/bash
setup-osx:
	if python -mplatform | grep -qi Darwin; then
		echo "Setting up for OS X via brew..."
		brew update
		brew install python python3 neovim ripgrep
		pip install Pygments
	fi

setup: setup-osx setup-ubuntu

.ycm: .git/modules/YouCompleteMe/HEAD
	./vim/.vim/bundle.vim/YouCompleteMe/install.py --clang-completer
	touch .ycm

.fzf: .git/modules/fzf/HEAD
	printf 'y\ny\nn\n' | ./vim/.vim/bundle/fzf/install
	touch .fzf

.fzf-clean:
	echo 'y' | ./vim/.vim/bundle/fzf/uninstall
	rm .fzf

all: .ycm .fzf

clean: .fzf-clean

install: all
	stow */
	ln -sfn ~/.vim ~/.config/nvim
	ln -sf ~/.vimrc ~/.config/nvim/init.vim

uninstall:
	stow -D */
