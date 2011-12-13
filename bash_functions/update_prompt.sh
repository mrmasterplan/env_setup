
function update_prompt {
    if [ -z "$STY" ]; then
        PS1="\$(date +%H:%M) \h \W> "
        return 0
    fi

    local session_base=$(echo $STY | sed 's/[0-9]*\.\(.*\)/\1/g')
    local sessions="$(screen -ls $session_base| grep "$session_base")"
    local n_sessions="$(echo "$sessions" | wc -l)"
    
    if [ "$n_sessions" -lt 2 ]; then
        PS1="[$session_base] \$(date +%H:%M) \h \W> "
        return 0
    fi
    
    local i_session="$(echo "$sessions" | grep -n $STY | sed 's/^\([0-9]*\):.*/\1/g')"
    
    PS1="[$session_base:$i_session/$n_sessions] \$(date +%H:%M) \h \W> "
}

alias upps1="update_prompt"