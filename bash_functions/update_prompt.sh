
# function update_prompt {
#     if [ -z "$STY" ]; then
#         PS1="\$(date +%H:%M) \h \W> "
#         return 0
#     fi
# 
#     local session_base=$(echo $STY | sed 's/[0-9]*\.\(.*\)/\1/g')
#     local sessions="$(screen -ls $session_base| grep "$session_base")"
#     local n_sessions="$(echo "$sessions" | wc -l)"
#     
#     if [ "$n_sessions" -lt 2 ]; then
#         PS1="[$session_base] \$(date +%H:%M) \h \W> "
#         return 0
#     fi
#     
#     local i_session="$(echo "$sessions" | grep -n $STY | sed 's/^\([0-9]*\):.*/\1/g')"
#     
#     PS1="[$session_base:$i_session/$n_sessions] \$(date +%H:%M) \h \W> "
# }

function update_prompt {
    local pid=$(echo $STY | egrep -o "^[0-9][0-9]*")
    if [ ! -z "$pid" ]; then
        local new_STY="$(screen -ls | grep --color=no -o "$pid[^[:space:]]*")"
        if [ "${new_STY:0:${#pid}}" == "$pid" ]; then
            export STY="$new_STY"
        fi
    fi
        
    if [ ! -z "$STY" ]; then
        local sess_name="${STY##*.}"
        # echo -ne "\033]0;$sess_name@${HOSTNAME%%.*}\007"
        echo -ne "\033]0;$sess_name\007"
        # echo -ne "\\033]0;$(echo $STY | sed "s/[0-9]*\.\(.*\)/\1/g")\\a"
    fi
}

alias upps1="update_prompt"