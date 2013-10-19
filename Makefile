# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`


all: bash vim git screen jshint jsctags

bash:
	@ln -fs ${PWD}/bash/bashrc ~/.bashrc
	@ln -fs ${PWD}/bash/profile ~/.profile
	@ln -fs ${PWD}/bash/bash_aliases ~/.bash_aliases

vim:
	@ln -fsn ${PWD}/vim/ ~/.vim
	@ln -fs ${PWD}/vim/vimrc ~/.vimrc
	-@[ -d ~/.vim/bundle/vundle ] || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@vim +BundleInstall +qall
	-@sudo apt-get install exuberant-ctags
	-@sudo apt-get install ruby-dev
	-@cd ~/.vim/bundle/Command-T/ruby/command-t/ && ruby extconf.rb && make	# Prepares Command-T extension
	-@sudo apt-get install ack-grep
	-@cd ~/.vim/bundle/tern_for_vim/ && sudo npm install

git:
	@cp -f git/gitconfig ~/.gitconfig
	@ln -fs ${PWD}/git/gitconfig_template ~/.gitconfig_template
	@ln -fsn ${PWD}/git/git_template/ ~/.git_template
	@echo "*** NOTE! Remember to config the email in the ~/.gitconfig file"

screen:
	@ln -fs ${PWD}/screen/screenrc ~/.screenrc

jshint:
	@ln -fs ${PWD}/jshint/jshintrc ~/.jshint

jsctags: vim
	@make ${PWD}/vim/bundle/jsctags/Makefile

.PHONY: all bash vim git screen jshint jsctags

