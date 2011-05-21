
# Find out if it is necessary to set up root
if [ -z $(echo ${LD_LIBRARY_PATH} | grep $ROOTSYS) ]
then
	#Ok, root is not set up, or at least not properly.
	if [ -z $ROOTSYS ]
	then
		echo "ROOTSYS is not set up. Cannot set up root."
	else
		source $ROOTSYS/bin/thisroot.sh
	fi
fi