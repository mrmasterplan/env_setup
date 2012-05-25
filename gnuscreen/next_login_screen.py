#!/usr/bin/env python

# the base name of screen sessions will be:
base_name="login_"

import os, sys, re, commands, time

screenls = commands.getoutput("screen -ls")

# find the screen command line arguments
screenrc=""
if len(sys.argv) > 1:
    screenrc= "-c "+os.path.expanduser(os.path.expandvars(sys.argv[1]))

# find attached or detached sceen session indices:
query=re.compile(r"\t(?P<full>[0-9]+\."+base_name+r"(?P<index>[0-9]+))\t\((?P<state>.*?)\)")
detached=[]
attached=[]
for match in query.finditer(screenls):
    if match.group("state") == "Detached":
        detached+=[int(match.group("index"))]
    else:
        attached+=[int(match.group("index"))]

# find out which screen session you will attach to:
if detached:
    # use the lowest free index
    index = min(detached)
else:
    if attached:
        # or extend the list by one
        index = max(attached) +1
    else:
        # or start a new list
        index=0

session = "%s%d"%(base_name,index)

# get screen socket folder:
match=re.search(r"[0-9]+ Sockets? in (?P<dir>/.*)\.",screenls)
screen_dir = match.group("dir")

# reserve the screen session by creating a named pipe with its name:
placeholder =screen_dir+"/0000."+session
os.mkfifo(placeholder)

# tell the user what you are doing:
print screenls
print "           connecting to",
if detached:
    print "DETACHED",
else:
    print "NEW",

print "session named",session

# and wait for her to read it:
time.sleep(2)

# remove the placeholder 
os.unlink(placeholder)

command="screen %s -RR %s"%(screenrc,session)
# pass control to screen:
os.execvp("screen",command.split())
