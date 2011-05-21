
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
	PREVDIR=$PWD
	cd $SFRAME_DIR
	unset SFRAME_DIR
	. setup.sh
	cd $PREVDIR
	unset PREVDIR
	return 0
}

function clean_sframe {
	make distclean
	/bin/rm -r jobTempOutput_*
}