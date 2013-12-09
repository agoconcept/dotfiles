# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`

all: bash zsh vim git tmux ssh konsole jshint

bash:
	@ln -fs ${PWD}/bash/bashrc ~/.bashrc
	@ln -fs ${PWD}/bash/profile ~/.profile
	@ln -fs ${PWD}/bash/bash_aliases ~/.bash_aliases
	@ln -fs ${PWD}/bash/bash_colors ~/.bash_colors

zsh:
	@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

vim:
	@mkdir -p ~/.tmp/
	@ln -fsn ${PWD}/vim/ ~/.vim
	@ln -fs ${PWD}/vim/vimrc ~/.vimrc
	@ln -fs ${PWD}/vim/gvimrc ~/.gvimrc
	@ln -fs ${PWD}/vim/pdbrc ~/.pdbrc
	-@[ -d ~/.vim/bundle/vundle ] || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	@vim +BundleInstall +qall
	-@sudo apt-get install exuberant-ctags
	-@sudo apt-get install ack-grep
	#-@cd ~/.vim/bundle/tern_for_vim/ && sudo npm install
	-@sudo easy_install vimpdb
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
	@ln -fs ${PWD}/git/gitconfig ~/.gitconfig
	@ln -fs ${PWD}/git/gitconfig_template ~/.gitconfig_template
	@ln -fsn ${PWD}/git/git_template/ ~/.git_template
	@echo "*** NOTE! Remember to config the email in the ~/.gitconfig file"

tmux:
	@ln -fs ${PWD}/tmux/tmux.conf ~/.tmux.conf
	-@[ -d ${PWD}/powerline ] || git clone https://github.com/Lokaltog/powerline ${PWD}/powerline
	-@cd ${PWD}/powerline/ && sudo python setup.py install

ssh:
	@ln -fs ${PWD}/ssh/config ~/.ssh/config

konsole:
	@ln -fs ${PWD}/konsole/tmux.profile ~/.kde/share/apps/konsole/tmux.profile
	@ln -fs ${PWD}/konsole/DarkPastels.colorscheme ~/.kde/share/apps/konsole/DarkPastels.colorscheme
	@ln -fs ${PWD}/konsole/WhiteOnBlack.colorscheme ~/.kde/share/apps/konsole/WhiteOnBlack.colorscheme

jshint:
	@ln -fs ${PWD}/jshint/jshintrc ~/.jshint

.PHONY: all bash zsh vim git tmux ssh konsole jshint

