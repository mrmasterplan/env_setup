# Make screen nicer
if [ x"$LOCALNAME" == x"MyMacBookPro" ]
then
	SCREENRC=$ENV_SETUP_DIR/gnuscreen/mac_screenrc
else
	SCREENRC=$ENV_SETUP_DIR/gnuscreen/screenrc
fi

if [ x"$(readlink ~/.screenrc)" != x$SCREENRC ]
then
	if [ -e ~/.screenrc ]
	then
		echo "Backing up your ~/.screenrc to use my own."
		mv ~/.screenrc ~/.screenec.backup
	fi
	ln -s $SCREENRC ~/.screenrc
fi