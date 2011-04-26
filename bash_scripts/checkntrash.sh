
function checkntrash {
    
    if [[ $(pwd -P) = /afs/* ]]
    then
        /bin/rm $@
    else
        trash $@
    fi
}
alias rm='checkntrash'