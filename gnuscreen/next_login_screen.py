#!/usr/bin/env python

# the base name of screen sessions will be:
base_name="login_"

import os, sys, re, commands, time

verbose=False

screenls = commands.getoutput("screen -ls")

# find the screen command line arguments
screenrc=""
if len(sys.argv) > 1:
    screenrc= "-c "+os.path.expanduser(os.path.expandvars(sys.argv[1]))

# get screen socket folder:
match=re.search(r".* Sockets? (found )?in (?P<dir>/.*)\.",screenls)
screen_dir = match.group("dir")

# find attached or detached sceen session indices:
query=re.compile(r"\t(?P<full>[0-9]+\."+base_name+r"(?P<index>[0-9]+))\t\((?P<state>.*?)\)")
detached={}
attached=[]
for match in query.finditer(screenls):
    if match.group("state") == "Detached":
        detached[int(match.group("index"))]=match.group("full")
    else:
        attached+=[int(match.group("index"))]

for key in detached.keys():
    if os.path.exists(screen_dir+"/"+detached[key]+"_attaching"):
        del detached[key]

# find out which screen session you will attach to:
if detached:
    # use the lowest free index
    index = min(detached.keys())
    
    # reserve the screen session by creating a reserving file:
    placeholder = screen_dir+"/"+detached[index]+"_attaching"
    open(placeholder,"w").close()
else:
    if attached:
        # or extend the list by one
        index = max(attached) +1
    else:
        # or start a new list
        index=0
    
    # reserve the screen session by creating a named pipe with its name:
    placeholder =screen_dir+"/0000.%s%d"%(base_name,index)
    os.mkfifo(placeholder)

session = "%s%d"%(base_name,index)



# tell the user what you are doing:
if verbose: 
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
