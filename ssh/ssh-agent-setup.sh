# Set up the ssh-agent so that it is available on every shell on this system

#The location to save the output of ssh-agent, i.e. the environment for the ssh-agent
SSH_AGENT_SETUP="$ENV_SETUP_DIR/ssh/sshagent_setup"

# set up the environment from an existing environemt setup file
function sshagentenv {
	if [ -e $SSH_AGENT_SETUP ]
	then
		eval "$(cat $SSH_AGENT_SETUP)" >/dev/null
	fi
}

# check if the environment is still relevent
function sshagentalive {
	if [ -z "$SSH_AGENT_PID" ]
	then
		sshagentenv
	fi
		
	if [ ! -z "$(ps -p $SSH_AGENT_PID 2>&1 | grep ssh-agent)" ]
	then
		echo "alive"
	else
		echo "dead"
	fi
}

function sshagent {
	ssh-agent >$SSH_AGENT_SETUP
	eval "$(cat $SSH_AGENT_SETUP)"
	ssh-add ~/.ssh/id_rsa.protected
	ssh-add ~/.ssh/id_rsa.git
	ssh-add ~/.ssh/id_rsa.open
}

sshagentenv

if [ "$(sshagentalive)" == "dead" ]
then
	echo "The ssh-agent is dead, you need to make a new one with sshagent"
fi

