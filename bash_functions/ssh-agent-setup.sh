# Set up the ssh-agent so that it is available on every shell on this system
if [ $LOCALNAME == "SIMON_MBP" ]; then
	#The location to save the output of ssh-agent, i.e. the environment for the ssh-agent
	export SSH_AGENT_SETUP="$ENV_SETUP_DIR/sshagent_setup"

	# set up the environment from an existing environemt setup file
	function sshagentenv {
		if [ -e $SSH_AGENT_SETUP ]
		then
			eval "$(<$SSH_AGENT_SETUP)" 2>&1 >/dev/null
		fi
	}

	# check if the environment is still relevent
	function sshagentalive {
		#if the ssh-agent environment isn't present, set it up
		MyEnv=""
		if [ -z "$SSH_AGENT_PID" ]
		then
			MyEnv="TRUE"
			sshagentenv
		fi
		retval=0
		# if that didn't succeed, it's definitely dead.
		if [ -z "$SSH_AGENT_PID" ]
		then
			echo "The ssh-agent is dead, you need to make a new one with sshagent"
			retval=127
		else
			# now check if the process exists
			if [ ! -z "$(ps -p $SSH_AGENT_PID 2>&1 | grep ssh-agent)" ]
			then
				echo "The ssh-agent is alive."
				retval=0
			else
				echo "The ssh-agent is dead, you need to make a new one with sshagent"
				retval=127
			fi
		fi
		
		if [ ! -z $MyEnv ]; then
			unset SSH_AUTH_SOCK
			unset SSH_AGENT_PID
			unset MyEnv
		fi
		return $retval
	}

	function sshagent {
		# This is how one starts an ssh-agent.
		ssh-agent >$SSH_AGENT_SETUP
		eval "$(cat $SSH_AGENT_SETUP)"
		ssh-add ~/.ssh/id_rsa.protected
		ssh-add ~/.ssh/id_rsa.git
		ssh-add ~/.ssh/id_rsa.open
	}

fi
