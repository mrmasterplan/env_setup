#!/bin/bash

if [ x"$ENV_SETUP_DIR" == x ]
then
	export ENV_SETUP_DIR="$HOME/.env_setup"
fi

echo "Setting up your environment from $ENV_SETUP_DIR"

# [ x"$LOCALNAME" == x"MyMacBookPro" ] determines this to be my MBP


# Set up the shell so that it behaves nicely
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
export PS1="\u@\h \W> "

# Set up the ssh names of a number of frequently accessed resources
export lxplus="heisterk@lxplus5.cern.ch"
export pcnbi1="heisterk@pcnbi1.cern.ch"
export heppc="simonhe@heppc19.nbi.dk"
export steno1="simonhe@fend01.dcsc.ku.dk"
export steno2="simonhe@fend02.dcsc.ku.dk"
export wgserv=$steno2
export cernvm="192.168.100.132"
export top="simonhe@top.nbi.dk"
export mdjmac="simon@imac.mdj.dk"

alias lx='ssh -X -Y $lxplus'
alias mac='ssh -X -Y $mdjmac'
alias wg="ssh -X -Y $wgserv"
alias ll='ls -lG'
alias la='ls -laG'
alias lh='ls -lhG'
alias ls="ls -G"
alias py="python"

#Stuff that is specifit to my Mac
if [ x"$LOCALNAME" == x"MyMacBookPro" ]; then
	alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	. $ENV_SETUP_DIR/bash_scripts/checkntrash.sh
fi
alias delete='/bin/rm'

#Some bash functions
. $ENV_SETUP_DIR/bash_scripts/cleanemacs.sh
. $ENV_SETUP_DIR/bash_scripts/mkcd.sh
. $ENV_SETUP_DIR/bash_scripts/fullls.sh

# Make python nicer:
export PYTHONSTARTUP="$ENV_SETUP_DIR/python/pystartup.py"

# Make screen nicer
if [ x"$(readlink ~/.screenrc)" != x$ENV_SETUP_DIR/gnuscreen/screenrc ]
then
	echo "Backing up your ~/.screenrc to use my own."
	mv ~/.screenrc ~/.screenec.backup
	ln -s $ENV_SETUP_DIR/gnuscreen/screenrc ~/.screenrc
fi