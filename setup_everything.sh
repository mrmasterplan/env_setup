#!/bin/bash

#Find out where you are, so you know where to import from.
OLDDIR=$PWD
cd $(dirname $BASH_SOURCE)
export ENV_SETUP_DIR="$(pwd -P)"
cd $OLDDIR

echo -n "Setting up your environment from $ENV_SETUP_DIR at "; date

# [ x"$LOCALNAME" == x"MyMacBookPro" ] determines this to be my MBP


# Set up the shell so that it behaves nicely
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
export PS1="#\u@\h \W> "

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
alias root='root -l'
alias '2up=psnup -pa4 -2'
alias 'a=alias'
alias 'cp=cp -i'
alias 'df=df -h'
alias 'du=du -h'
alias 'du1=du --max-depth=1'
alias 'du2=du --max-depth=2'
alias "py=python"
alias 'e=emacs --no-site-file -nw' 
alias 'h=history'
alias 'l=ls -FlhG'
alias 'l.=ls -dhG .*'
alias 'la=ls -lAG'
alias 'll=ls -lG'
alias 'lh=ls -lhG'
alias 'ls=ls -G'
alias 'lsa=ls -A'
alias 'mv=mv -i'
alias 'purge=rm -f *~ .*~ #* *#'
alias 'purgeall=purge;purgetex;purgemf'
alias 'purgetex=rm -if *.toc *.aux *.log'
alias 't=tree'
alias 'td=tree -d'
alias 'tree=tree -C'
alias 'up=cd ..'
alias 'find=find . -name'
alias ttop='top -U $USER'
 

#Stuff that is specifit to my Mac
if [ x"$LOCALNAME" == x"MyMacBookPro" ]; then
	alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	. $ENV_SETUP_DIR/bash_scripts/checkntrash.sh
	
	. $ENV_SETUP_DIR/ssh/ssh-agent-setup.sh
	
else
	alias emacs='emacs -nw'
fi
alias delete='/bin/rm'

#Some bash functions
. $ENV_SETUP_DIR/bash_scripts/cleanemacs.sh
. $ENV_SETUP_DIR/bash_scripts/mkcd.sh
. $ENV_SETUP_DIR/bash_scripts/fullls.sh
. $ENV_SETUP_DIR/bash_scripts/toggleHidden.sh
. $ENV_SETUP_DIR/bash_scripts/authentication.sh #sets up ck and nk
. $ENV_SETUP_DIR/bash_scripts/nice_man.sh

#Make sure that boost is properly included
# if [ x"$BOOST_ROOT" != x ]
# then
# 	export LIBPATH="$BOOST_ROOT/lib:$LIBPATH"
# 	export LD_LIBRARY_PATH="$BOOST_ROOT/lib:$LD_LIBRARY_PATH"
# 	export DYLD_LIBRARY_PATH="$BOOST_ROOT/lib:$DYLD_LIBRARY_PATH"
# 	export PATH="$BOOST_ROOT:$PATH"
# 	export CPLUS_INCLUDE_PATH="$BOOST_ROOT:$CPLUS_INCLUDE_PATH"
# fi	

# Make python nicer:
export PYTHONSTARTUP="$ENV_SETUP_DIR/python/pystartup.py"

. $ENV_SETUP_DIR/gnuscreen/setup_screen.sh