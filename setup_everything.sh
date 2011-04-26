#!/bin/bash

# [ x"$LOCALNAME" == x"MyMacBookPro" ] determines this to be my MBP
# [ x"$LOCALNAME" == x"MyMacBookPro" ] determines this to be my MBP

echo "Setting up your environment."

# Set up the shell so that it behaves nicely
bind '"\e[A"':history-search-backward
bind '"\e[B"':history-search-forward
export PS1="\u@\h \W> "

# Set up the ssh names of a number of frequently accessed resources
export lxplus="heisterk@lxplus5.cern.ch"
export pcnbi1="heisterk@pcnbi1.cern.ch"
export heppc="simonhe@heppc19.nbi.dk"
export steno1="simonhe@fend01.dcsc.ku.dk"
export steno2="simonhe@fend02.dcsc.ku.dk"
export wgserv=$steno2
export cernvm="192.168.100.132"
export top="simonhe@top.nbi.dk"
export mdjmac="simon@imac.mdj.dk"
