if [ $LOCALNAME == "SIMON_MBP" ]; then

	function journal {
		mate ~/Documents/Journal/journal.txt
	}
	alias j='journal'

	function backup_journal {
		oldwd=$PWD
		cd ~/Documents/Journal
		svn ci -m "Journal checkin"
		cd $oldwd
	}

fi