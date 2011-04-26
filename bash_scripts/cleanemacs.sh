function cleanemacs {
    echo "Deleting all emacs *~ and #*# files."
    for i in *~
    do
        if [ -e $i ]
            then 
            /bin/rm $i
        fi
    done
    for i in \#*\#
    do
        if [ -e $i ]
            then 
            /bin/rm $i
        fi
    done
}

alias ce="cleanemacs"