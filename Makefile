# Makefile for (un)installing dotfiles

# Current directory
PWD=`pwd`

# konsole directory
KONSOLE_DIR=~/.local/share/konsole

all: bash curl zsh git tmux ssh konsole jshint vim

bash:
	@ln -fs ${PWD}/bash/bashrc ~/.bashrc
	@ln -fs ${PWD}/bash/profile ~/.profile
	@ln -fs ${PWD}/bash/bash_aliases ~/.bash_aliases
	@ln -fs ${PWD}/bash/bash_colors ~/.bash_colors
	@ln -fs ${PWD}/bash/git-prompt-colors.sh ~/.git-prompt-colors.sh
	-@git clone https://github.com/agoconcept/bash-git-prompt.git ~/.bash-git-prompt

curl:
	-@sudo apt-get -y install curl

zsh:
	-@sudo apt-get -y install zsh
	@ln -fs ${PWD}/zsh/zshrc ~/.zshrc
	-@curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh

fonts:
	-@sudo apt-get -y install fontconfig
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

vdebug:
	@mkdir -p ~/.vdebug/
	@wget -P ~/.vdebug/ -N http://downloads.activestate.com/Komodo/releases/8.5.3/remotedebugging/Komodo-PythonRemoteDebugging-8.5.3-83298-linux-x86_64.tar.gz
	@tar xvzf ~/.vdebug/Komodo-PythonRemoteDebugging-8.5.3-83298-linux-x86_64.tar.gz -C ~/.vdebug/
	@patch -N ~/.vdebug/Komodo-PythonRemoteDebugging-8.5.3-83298-linux-x86_64/dbgp/client.py < vim/vdebug.patch
	@ln -fs ~/.vdebug/Komodo-PythonRemoteDebugging-8.5.3-83298-linux-x86_64/pythonlib/dbgp ~/.vdebug/Komodo-PythonRemoteDebugging-8.5.3-83298-linux-x86_64/dbgp

git:
	@ln -fs ${PWD}/git/gitconfig ~/.gitconfig
	@ln -fs ${PWD}/git/gitconfig_template ~/.gitconfig_template
	@ln -fsn ${PWD}/git/git_template/ ~/.git_template
	@echo "*** NOTE! Remember to config the email in the ~/.gitconfig file"

tmux:
	-@sudo apt-get -y install tmux python-setuptools sysstat
	@ln -fs ${PWD}/tmux/tmux.conf ~/.tmux.conf
	-@[ -d ${PWD}/powerline ] || git clone https://github.com/Lokaltog/powerline ${PWD}/powerline
	-@cd ${PWD}/powerline/ && sudo python2 setup.py install

ssh:
	@mkdir -p ~/.ssh/
	@ln -fs ${PWD}/ssh/config ~/.ssh/config

konsole:
	[ -d ${KONSOLE_DIR} ] && ln -fs ${PWD}/konsole/tmux.profile ${KONSOLE_DIR}/tmux.profile
	[ -d ${KONSOLE_DIR} ] && ln -fs ${PWD}/konsole/DarkPastels.colorscheme ${KONSOLE_DIR}/DarkPastels.colorscheme
	[ -d ${KONSOLE_DIR} ] && ln -fs ${PWD}/konsole/WhiteOnBlack.colorscheme ${KONSOLE_DIR}/WhiteOnBlack.colorscheme

jshint:
	-@ln -fs ${PWD}/jshint/jshintrc ~/.jshint

vim: fonts
	-@sudo apt-get -y install vim
	-@sudo apt-get -y install exuberant-ctags ack-grep silversearcher-ag
	-@sudo apt-get -y install pylint python-setuptools python-coverage
	-@sudo apt-get -y install python-flake8
	@mkdir -p ${PWD}/vim/tmp/backup/
	@mkdir -p ${PWD}/vim/tmp/swap/
	@mkdir -p ${PWD}/vim/tmp/undo/
	@ln -fsn ${PWD}/vim/ ~/.vim
	@ln -fs ${PWD}/vim/vimrc ~/.vimrc
	@ln -fs ${PWD}/vim/gvimrc ~/.gvimrc
	@ln -fs ${PWD}/vim/pdbrc ~/.pdbrc
	@ln -fs ${PWD}/vim/wakatime.cfg ~/.wakatime.cfg
	@sudo ln -fs /usr/bin/coverage2 /usr/local/bin/coverage 			# For python coverage to work
	-@[ -d ~/.vim/bundle/vundle ] || git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
	-@sudo easy_install vimpdb
	@vim -i NONE -c VundleInstall -c quitall
	#-@cd ~/.vim/bundle/tern_for_vim/ && sudo npm install

.PHONY: all bash zsh vim git tmux ssh konsole jshint

