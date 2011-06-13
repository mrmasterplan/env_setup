
function setup_sframe {
	
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
	
	if [ -e ~/code/SFrame_meta_tools/setup.sh ]
		then
		source ~/code/SFrame_meta_tools/setup.sh
	fi
	
	return 0
}

function clean_sframe {
	make distclean
	/bin/rm -r jobTempOutput_*
}