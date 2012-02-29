#!/usr/bin/env python

import os, sys, re, commands, time
screenls = commands.getoutput("screen -ls")
print screenls

screenrc=""
if len(sys.argv) > 1:
    screenrc= "-c "+os.path.expanduser(os.path.expandvars(sys.argv[1]))

base_name="login_"

# find attached or detached sceen sessions:
query="""\t(?P<full>[0-9]+\."""+base_name+"""(?P<index>[0-9]+))\t\(%s\)"""
detached=[int(match.group("index")) for match in re.finditer(query%"Detached",screenls)]
attached=[int(match.group("index")) for match in re.finditer(query%"Attached",screenls)]

print "           connecting to",
if detached:
    # use the lowest free index
    print "DETACHED session named",
    index = min(detached)
else:
    print "NEW session named",
    if attached:
        # or extend the list by one
        index = max(attached) +1
    else:
        # or start a new list
        print "NEW session named",
        index=0

print "%s%d"%(base_name,index)
time.sleep(2)
command="screen %s -RR %s%d"%(screenrc,base_name,index)
# pass control to screen:
os.execvp("screen",command.split())
