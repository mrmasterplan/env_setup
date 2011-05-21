
#  The following function will recursively list all files in or 
#  under the arguments and will output their full path.
function fullls {
    for file in "$@"
    do
        if [ -f "$file" ]
        then
            local lastloc="$PWD"
            cd $(dirname "$file")
            echo $(pwd -P)/$(basename "$file")
            cd "$lastloc"
        fi
        
        if [ -d "$file" ] 
        then
            local lastloc="$PWD"
            cd "$file"
           # echo "location now $PWD"
            for line in $(ls)
            do
                fullls "$line"
            done
            cd "$lastloc"
        fi
    done
    
    if (( $# == 0 ))
    then
        fullls "$PWD"
    fi
}

