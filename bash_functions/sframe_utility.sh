
function setdown_sframe {
    if [ -z "$SFRAME_DIR" ]; then 
        return 0; 
    fi
    
    export PATH="$(echo $PATH | sed "s@$SFRAME_DIR/bin:*@@g")"
    export PYTHONPATH="$(echo $PYTHONPATH | sed "s@$SFRAME_DIR/python:*@@g")"
    export PAR_PATH="$(echo $PATH | sed "s@$SFRAME_DIR/lib:*@@g")"
    export DYLD_LIBRARY_PATH="$(echo $PATH | sed "s@$SFRAME_DIR/lib:*@@g")"
    unset SFRAME_LIB_PATH
    unset SFRAME_BIN_PATH
    unset SFRAME_DIR
}

function setup_sframe {
	
	
	if [ ! -z "${SFRAME_DIR}" ];
	then
		echo "SFrame is already set up to $SFRAME_DIR. Removing it"
		setdown_sframe
	fi
	
	for sframe in ./SFrame ../SFrame $HOME/software/SFrame/ $HOME/software/SFrame/SFrame_trunk
	do
	    if [ -e $sframe/setup.sh ];
	        then
	        if [ ! -z "$(cd $sframe; . setup.sh &>/dev/null; echo \$SFRAME_DIR)" ]
	            then
	            break
            fi
        fi
    done
    
    if [ -z "$sframe" ]
        then
        echo "Could not find SFrame!"
        return 127
    fi
    echo "Setting up SFrame from $(cd $sframe; pwd)"
    
	local PREVDIR=$PWD
	local PREVOLDPWD=$OLDPWD
	cd $sframe
	. setup.sh
	cd $PREVDIR
	export OLDPWD=$PREVOLDPWD
	
	if [ -e ~/software/SFrame_meta_tools/setup.sh ]
		then
		source ~/software/SFrame_meta_tools/setup.sh
	fi
	
	return 0
}

function clean_sframe {
	make distclean
	/bin/rm -r jobTempOutput_*
}


