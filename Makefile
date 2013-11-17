# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`


all: bash vim git screen tmux konsole jshint

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
	-@sudo apt-get install fontconfig
	@mkdir -p ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/AnonymousPro/*.ttf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/DejaVuSansMono/*.ttf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/DroidSansMono/*.otf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/Inconsolata/*.otf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/InconsolataDz/*.otf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/LiberationMono/*.ttf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/Meslo/*.otf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/SourceCodePro/*.otf ~/.fonts/
	@ln -fs ${PWD}/vim/bundle/powerline-fonts/UbuntuMono/*.ttf ~/.fonts/
	@fc-cache -vf ~/.fonts

git:
	@cp -f git/gitconfig ~/.gitconfig
	@ln -fs ${PWD}/git/gitconfig_template ~/.gitconfig_template
	@ln -fsn ${PWD}/git/git_template/ ~/.git_template
	@echo "*** NOTE! Remember to config the email in the ~/.gitconfig file"

screen:
	@ln -fs ${PWD}/screen/screenrc ~/.screenrc

tmux:
	@ln -fs ${PWD}/tmux/tmux.conf ~/.tmux.conf

konsole:
	@ln -fs ${PWD}/konsole/tmux.profile ~/.kde/share/apps/konsole/tmux.profile

jshint:
	@ln -fs ${PWD}/jshint/jshintrc ~/.jshint

.PHONY: all bash vim git screen tmux konsole jshint

