#!/bin/bash

#Find out where you are, so you know where to import from.
OLDDIR=$PWD
cd $(dirname $BASH_SOURCE)
export ENV_SETUP_DIR="$(pwd -P)"
cd $OLDDIR


if [ ! -z "$(which ifconfig 2>/dev/null)" -a ! -z "$(which md5 2>/dev/null)" ] ; then
	Mac_Adr_Hash="$(ifconfig | grep lladdr | sed 's/.*lladdr //' | md5 -q)"
	if [ x$Mac_Adr_Hash == x"1ec48be6ee2d4027d78da2a9360dd922" ];then
        export LOCALNAME="SIMON_MBP" 
	elif [ x$Mac_Adr_Hash == x"8f1e89697003bd87af5f43f9e78ce4d8" ];then
		export LOCALNAME="MDJ_IMAC"
	fi
fi

# Set up the shell so that it behaves nicely
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
export PS1="#\u@\h \W> "

#Pure function definitions. No environment is set
for i in $ENV_SETUP_DIR/bash_functions/*.sh
do
	source $i
done


function init {
	echo -n "Setting up your environment from $ENV_SETUP_DIR at "; date
	#Environment setup
	for i in $ENV_SETUP_DIR/bash_scripts/*.sh
	do
		source $i
	done
	

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
	alias 'purgetex=rm -if *.toc *.aux *.log *.mtc *.mtc0 *.maf'
	alias 't=tree'
	alias 'td=tree -d'
	alias 'tree=tree -C'
	alias 'up=cd ..'
	alias ttop='top -U $USER'
	alias ce="cleanemacs"
	
	export myrepo="file:///afs/cern.ch/project/svn/reps/reposheisterk"
	
	
	if [ -z "$(which tree)" ]; then
		alias "tree=find . -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'"
	fi 

	if [ x"$LOCALNAME" == x"SIMON_MBP" ]; then
		#setup emacs
		alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
		#Set up the ssh-agent
		sshagentenv
		sshagentalive
	else
		alias emacs='emacs -nw'
	fi
	alias delete='/bin/rm'

	#Make sure that boost is properly included
	setup_boost
	
	setup_sframe
	
	# Make python nicer:
	export PYTHONSTARTUP="$ENV_SETUP_DIR/python/pystartup.py"
	export PYTHONPATH="$ENV_SETUP_DIR/python/:$PYTHONPATH"

	unset init
}