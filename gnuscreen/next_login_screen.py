#!/usr/bin/env python

import os, sys, re, commands
screenls = commands.getoutput("screen -ls")

screenrc=""
if len(sys.argv) > 1:
    screenrc= "-c "+os.path.expanduser(os.path.expandvars(sys.argv[1]))

base_name="login_"

# find attached or detached sceen sessions:
query="""\t(?P<full>[0-9]+\."""+base_name+"""(?P<index>[0-9]+))\t\(%s\)"""
detached=[int(match.group("index")) for match in re.finditer(query%"Detached",screenls)]
attached=[int(match.group("index")) for match in re.finditer(query%"Attached",screenls)]

if detached:
    # use the lowest free index
    index = min(detached)
elif attached:
    # or extend the list by one
    index = max(attached) +1
else:
    # or start a new list
    index=0

command="screen %s -RR %s%d"%(screenrc,base_name,index)
# pass control to screen:
os.execvp("screen",command.split())
