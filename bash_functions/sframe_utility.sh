
function setup_sframe {
	
	if  command -v env-watcher &>/dev/null
		then
		env-watcher -f start sframe
	fi
	
	if [ ! -z "${SFRAME_DIR}" -a ! -z "${SFRAME_LIB_PATH}" ];
	then
		echo "SFrame is already set up."
		return 127
	fi
	
	if [ -z "${SFRAME_DIR}" ]
	then
		if [ -e $HOME/software/SFrame/trunk ]
		then 
			SFRAME_DIR=$HOME/software/SFrame/trunk
		else
			echo "SFRAME_DIR not set."
			return 127
		fi
	fi
	local PREVDIR=$PWD
	local PREVOLDPWD=$OLDPWD
	cd $SFRAME_DIR
	unset SFRAME_DIR
	. setup.sh
	cd $PREVDIR
	export OLDPWD=$PREVOLDPWD
	
	if [ -e ~/software/SFrame_meta_tools/setup.sh ]
		then
		source ~/software/SFrame_meta_tools/setup.sh
	fi
	
	if  command -v env-watcher &>/dev/null
		then
		env-watcher -f stop sframe
	fi
	
	
	return 0
}

function clean_sframe {
	make distclean
	/bin/rm -r jobTempOutput_*
}