#!/usr/bin/env python

import os, sys, re, commands
screenls = commands.getoutput("screen -ls")


# problem, if there are more than one screens of the best index name, we should choose one of them.
# we need to save the full name as well as the index.
query="""\t(?P<full>[0-9]+\.login_(?P<index>[0-9]+))\t\(%s\)"""

detached=[(int(match.group("index")), match.group("full")) for match in re.finditer(query%"Detached",screenls)]
attached=[(int(match.group("index")), match.group("full")) for match in re.finditer(query%"Attached",screenls)]

if detached:
    name = min(detached)[1]
elif attached:
    name ="login_%d"%( max(attached)[0] + 1)
else:
    name ="login_0"
    
sys.exit(os.system("screen -RR %s -c ~/.env_setup/gnuscreen/screenrc_fend02_login" % name))
