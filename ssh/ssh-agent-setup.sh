# Set up the ssh-agent so that it is available on every shell on this system

SSH_AGENT_SETUP="$ENV_SETUP_DIR/ssh/sshagent_setup"

if [ -e $SSH_AGENT_SETUP ]
then
	eval "$(cat $SSH_AGENT_SETUP)" >/dev/null
	if [ -z x"$(ps -p $SSH_AGENT_PID | grep ssh-agent)" ]
	then
		#The ssh-agent is dead
		#/bin/rm $SSH_AGENT_SETUP
		echo "The ssh-agent is dead, you need to make a new one with sshagent"
	else
		if [ ! -z "$VERBOSE" ]; then
			echo "Set up your ssh-agent with Pid $SSH_AGENT_PID"
		fi
	fi
else
	echo "The ssh-agent is dead, you need to make a new one with sshagent"
fi

function sshagent {
	ssh-agent >$SSH_AGENT_SETUP
	eval "$(cat $SSH_AGENT_SETUP)"
	ssh-add ~/.ssh/id_rsa.protected
	ssh-add ~/.ssh/id_rsa.git
	ssh-add ~/.ssh/id_rsa.open
}
