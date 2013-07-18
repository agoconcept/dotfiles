# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`


all: bash vim

bash:
	@ln -fs ${PWD}/bash/bashrc ~/.bashrc
	@ln -fs ${PWD}/bash/profile ~/.profile

vim:
	@ln -fs ${PWD}/vim ~/.vim
	@ln -fs ${PWD}/vim/vimrc ~/.vimrc
	-@git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@vim +BundleInstall +qall

.PHONY: all bash vim

