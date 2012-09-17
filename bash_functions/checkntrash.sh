
function checkntrash {

    if [[ $(pwd -P) = /afs/* ]]
    then
        /bin/rm $@
    else
        $ENV_SETUP_DIR/bin/trash.py $@
    fi
}

# alias rm='checkntrash'
