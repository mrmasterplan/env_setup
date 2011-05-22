if [ $LOCALNAME == "SIMON_MBP" ]; then

	function journal {
		mate ~/Documents/Journal/journal.tex
	}
	alias j='journal'

	function journal_backup {
		oldwd=$PWD
		cd ~/Documents/Journal
		svn add contents/*
		svn ci -m "Journal checkin"
		cd $oldwd
	}

fi