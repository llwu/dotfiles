.PHONY: all install clean

.ycm: .git/modules/YouCompleteMe/HEAD
	./vim/.vim/bundle.vim/YouCompleteMe/install.py --clang-completer
	touch .ycm

all: .ycm

install: all
	stow */
	echo 'y\ny\nn' | ./vim/.vim/bundle/fzf/install
clean:
	stow -D */
	echo 'y' | ./vim/.vim/bundle/fzf/uninstall
