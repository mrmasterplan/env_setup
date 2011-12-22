#!/usr/bin/env python

import os, sys, re, commands
screenls = commands.getoutput("screen -ls")

screenrc=""
if len(sys.argv) > 1:
    screenrc= "-c "+os.path.expanduser(os.path.expandvars(sys.argv[1]))

# shell = "-s "+os.environ["SHELL"]

query="""\t(?P<full>[0-9]+\.login_(?P<index>[0-9]+))\t\(%s\)"""

detached=[int(match.group("index")) for match in re.finditer(query%"Detached",screenls)]
attached=[int(match.group("index")) for match in re.finditer(query%"Attached",screenls)]

index = 0
if detached:
    index = min(detached)
elif attached:
    index = max(attached) +1

name ="login_%d"%index
command="screen %s -RR %s"%(screenrc,name)
# os.system(command)
os.execvp("screen",command.split())