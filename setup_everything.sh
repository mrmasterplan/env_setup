#!/bin/bash

#Find out where you are, so you know where to import from.
export ENV_SETUP_DIR="$( cd $( dirname "${BASH_SOURCE[0]}" ) && pwd )"

source $ENV_SETUP_DIR/tools/get_locale.sh

# Set up the shell so that it behaves nicely
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward

# PS1="#\u@\h \W> "
PS1="#\$(date +%H:%M) \h \W> "
# PS1="\$(if (exit \$?); then echo \\033[m; else echo \\033[1m; fi)#\$(date +%H:%M) \h \W> \\033[m"

# PS1='$(echo $STY | sed "s/[0-9]*\.\(.*\)/[\1] /g")$(date +%H:%M) \h \W> ' # I now have the screen name in the window title.
# PROMPT_COMMAND='[ ! -z "$STY" ] && echo -ne "\033]0;$(echo $STY | sed "s/[0-9]*\.\(.*\)/\1/g")\007"'

# PS1="\$( [ ! -z "$STY" ] && echo  '\033]0;$(echo $STY | sed "s/[0-9]*\.\(.*\)/\1/g")\a')\$(date +%H:%M) \\h \\W> "

# PS1="\$( [ ! -z "$STY" ] && (echo  '\033]0;$(echo $STY | sed "s/[0-9]*\.\(.*\)/\1/g"))\a')\$(date +%H:%M) \\h \\W> "
#only is the variable STY is non-zero do you putput the control characters, followed by the crunched STY, then more control charactse.
# I read somewhere that the PROMPT_COMMAND should not be used.
# PS1="\$(screen -ls | grep --color=no -o \"\$PPID[^[:space:]]*\" | sed \"s/\$PPID\.\(.*\)/[\1] /g\")\$(date +%H:%M) \h \W> "
# results in: "[screen name] 12:35 host dirbase> "

# PS1="\[\033[1;34m\][\$(date +%H%M)][\u@\h:\w]$\[\033[0m\] "


if [ ! -z "$STY" ];
    then
        echo "==================="
        screen -ls
        echo "==================="
        echo "This is $STY"
        echo "==================="
    fi

export HISTIGNORE="anon-shell*:   *"

function init {
	echo -n "Setting up your environment from $ENV_SETUP_DIR at "; date
	
	#Pure function definitions. No environment is set
    for i in $ENV_SETUP_DIR/bash_functions/*.sh
        do
        	source $i
        done
    
	#Environment setup
	for i in $ENV_SETUP_DIR/bash_scripts/*.sh
	do
		source $i
	done
	


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
	alias rootcompile="$(root-config --cxx) $(root-config --cflags) $(root-config --libs)"
	
	if  command -v checkntrash &>/dev/null
		then
		alias rm='checkntrash'
		alias del='/bin/rm'
	fi
	
	alias astyle_all="astyle -n -A10 -r *.cxx *.h *.C *.icc *.c"
	
	export MYREPO="svn+ssh://heisterk@svn.cern.ch/reps/reposheisterk"
	
	
	if ! which tree &>/dev/null; then # if the tree command is not found,
		alias "tree=find . -print | grep -v '/\.' | sed -e 's;[^/]*/;|-- ;g;s;-- |;   |;g'"
	fi 

	if [ x"$LOCALNAME" == x"SIMON_MBP" ]; then
		#setup emacs
		alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'
	else
		alias emacs='emacs -nw'
	fi

	#Make sure that boost is properly included
    # setup_boost
	
	#setup_sframe
	
	# Make python nicer:
	export PYTHONSTARTUP="$ENV_SETUP_DIR/python/pystartup.py"
	export PYTHONPATH="$ENV_SETUP_DIR/python/:$PYTHONPATH"

    if [ -e ~/software/EnvWatcher/setup.sh ]
        then
        source ~/software/EnvWatcher/setup.sh
    fi

    update_prompt
	unset init
}
