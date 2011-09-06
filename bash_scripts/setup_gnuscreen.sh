# Make screen nicer
if [ x"$LOCALNAME" == x"SIMON_MBP" ]
then
	SCREENRC=$ENV_SETUP_DIR/gnuscreen/mac_screenrc
else
	SCREENRC=$ENV_SETUP_DIR/gnuscreen/screenrc
fi

if [ x"$(readlink ~/.screenrc)" != x"$SCREENRC" ]
then
	if [ -e ~/.screenrc ]
	then
		echo "Backing up your ~/.screenrc to use my own."
		/bin/mv ~/.screenrc ~/.screenrc.backup
	fi
	ln -s "$SCREENRC" ~/.screenrc
fi

# if [ ! -d $HOME/log/screen-logs ]; then
#   mkdir -p $HOME/log/screen-logs
# fi
