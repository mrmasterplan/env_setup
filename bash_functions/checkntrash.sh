
if [ ! -z "$VERBOSE" ]; then
	echo "'rm' now uses trash functionality"
fi

if [ -e /usr/bin/trash ]
then
	function checkntrash {
    
	    if [[ $(pwd -P) = /afs/* ]]
	    then
	        /bin/rm $@
	    else
	        trash $@
	    fi
	}
	
	alias rm='checkntrash'
	
fi
