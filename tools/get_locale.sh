

if [ ! -z "$(which ifconfig 2>/dev/null)" -a ! -z "$(which md5 2>/dev/null)" ] ; then
	Mac_Adr_Hash="$(ifconfig | grep lladdr | sed 's/.*lladdr //' | md5 -q)"
	if [ x$Mac_Adr_Hash == x"1ec48be6ee2d4027d78da2a9360dd922" ];then
        export LOCALNAME="SIMON_MBP" 
	elif [ x$Mac_Adr_Hash == x"8f1e89697003bd87af5f43f9e78ce4d8" ];then
		export LOCALNAME="MDJ_IMAC"
	fi
	unset Mac_Adr_Hash
fi