### All this is not needed on a Mac. I keep it here for archiving purposes:
# # Set up the ssh-agent so that it is available on every shell on this system
# #Find out where you are, so you know where to import from.
# if [ x$ENV_SETUP_DIR == x ]; then
#   previous_PWD=$PWD
#   previous_OLDPWD=$OLDPWD
#   cd $(dirname $BASH_SOURCE)
#   cd ..
#   export ENV_SETUP_DIR="$(pwd -P)"
#   cd $previous_PWD
#   OLDPWD=$previous_OLDPWD
#   unset previous_PWD
#   unset previous_OLDPWD
# fi
# 
# if [ "x$LOCALNAME" == x ]; then
#   source $ENV_SETUP_DIR/tools/get_locale.sh
# fi
# 
# if [ x$LOCALNAME == x"SIMON_MBP" ]; then
#     #The location to save the output of ssh-agent, i.e. the environment for the ssh-agent
#     export SSH_AGENT_SETUP="$ENV_SETUP_DIR/sshagent_setup.tmp"
# 
#     # set up the environment from an existing environemt setup file
#     function sshagentenv {
#         if [ -e $SSH_AGENT_SETUP ]
#         then
#             eval "$(<$SSH_AGENT_SETUP)" 2>&1 >/dev/null
#         fi
#     }
# 
#     # check if the environment is still relevent
#     function sshagentalive {
#         #if the ssh-agent environment isn't present, set it up
#         local MyEnv=""
#         if [ -z "$SSH_AGENT_PID" ]
#         then
#             MyEnv="TRUE"
#             sshagentenv
#         fi
#         retval=0
#         # if that didn't succeed, it's definitely dead.
#         if [ -z "$SSH_AGENT_PID" ]
#         then
#             echo "The ssh-agent is dead, you need to make a new one with sshagent"
#             retval=127
#         else
#             # now check if the process exists
#             if [ ! -z "$(ps -p $SSH_AGENT_PID 2>&1 | grep ssh-agent)" ]
#             then
#                 echo "The ssh-agent is alive."
#                 retval=0
#             else
#                 echo "The ssh-agent is dead, you need to make a new one with sshagent"
#                 retval=127
#             fi
#         fi
#         
#         if [ ! -z $MyEnv ]; then
#             unset SSH_AUTH_SOCK
#             unset SSH_AGENT_PID
#         fi
#         return $retval
#     }
# 
#     function sshagent {
#         # This is how one starts an ssh-agent.
#         ssh-agent >$SSH_AGENT_SETUP
#         eval "$(cat $SSH_AGENT_SETUP)"
#         ssh-add -k
#         # ssh-add -K ~/.ssh/id_rsa.protected
#         # ssh-add -K ~/.ssh/id_rsa.git
#         # ssh-add -K ~/.ssh/id_rsa.open
#     }
#     
#     # function env_setup_check_and_kill_ssh_agent {
#     #     if command -v bash_count &>/dev/null; then
#     #       local count=$(bash_count)
#     #       if [ $count -le 0 ]; then
#     #           ssh-agent -k
#     #           fi
#     #   fi
#     # }
# fi
