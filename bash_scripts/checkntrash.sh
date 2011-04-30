
if [ ! -z "$VERBOSE" ]; then
	echo "'rm' now uses trash functionality"
fi

function checkntrash {
    
    if [[ $(pwd -P) = /afs/* ]]
    then
        /bin/rm $@
    else
        trash $@
    fi
}
alias rm='checkntrash'