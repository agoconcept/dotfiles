# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`


all: bash-install vim-install

clean: bash-uninstall vim-uninstall

bash-install:
	@ln -fs ${PWD}/bash/bashrc ~/.bashrc
	@ln -fs ${PWD}/bash/profile ~/.profile

bash-uninstall:
	-@rm -f ~/.bashrc
	-@rm -f ~/.profile

vim-install:
	@ln -fs ${PWD}/vim ~/.vim
	@ln -fs ${PWD}/vim/vimrc ~/.vimrc

vim-uninstall:
	-@rm -fr ~/.vim
	-@rm -f ~/.vimrc

.PHONY: all clean

