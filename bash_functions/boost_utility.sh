
function setup_boost {
	#Check if there is anything to do
	if [ ! -z "${BOOST_ROOT}" ]
    then
        if [ ! -z "$(echo $LIBPATH | grep $BOOST_ROOT)" ];
        then
        	echo "BOOST is already set up."
        	return 127
        fi
    fi
	
	#Check if you even know what to do.
	if [ -z "${BOOST_ROOT}" ]
	then
		if [ x${LOCALNAME} == x"SIMON_MBP" ]
		then
			export BOOST_ROOT="/Users/simon/software/boost/boost_1_48_0"
		elif [ x${LOCALNAME} == x"MDJ_IMAC" ]
		then 
			export BOOST_ROOT="/Developer/boost_1_44_0"
		elif [ -e /software/hep/boost/1.46.1 ]
		then
			export BOOST_ROOT="/software/hep/boost/1.46.1"
		else
			echo "BOOST location unknown."
			return 127
		fi
	fi
	
	#alright, set up boost.
	export LIBPATH="$BOOST_ROOT/lib:$LIBPATH"
	export LD_LIBRARY_PATH="$BOOST_ROOT/lib:$LD_LIBRARY_PATH"
	export DYLD_LIBRARY_PATH="$BOOST_ROOT/lib:$DYLD_LIBRARY_PATH"
	export CPLUS_INCLUDE_PATH="$BOOST_ROOT/include:$CPLUS_INCLUDE_PATH"
	return 0
}