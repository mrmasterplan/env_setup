#!/usr/bin/env python

import os, re
from commands import getoutput

session_base="login_"
screenls=getoutput("screen -ls")

class screen:
    pass

sessions={}
detached_sessions=[]
attached_sessions=[]

for match in re.finditer("""\t(?P<pid>[0-9]+)\.(?P<name>login_(?P<index>[0-9]+))\t(?P<status>\(.*?\))""",screenls):
    # print "found index",match.group("index"),"called",match.group("name"),"with status",match.group("status")
    index=int(match.group("index"))
    s=screen()
    s.status=match.group("status")
    s.index=index
    s.name=match.group("name")
    s.pid=match.group("pid")
    sessions[index]=s
    if s.status=="(Detached)":
        detached_sessions.append(s)
    elif s.status=="(Attached)":
        attached_sessions.append(s)

detached_sessions.sort(lambda a,b: cmp(a.index,b.index))
attached_sessions.sort(lambda a,b: cmp(a.index,b.index))

if detached_sessions:
    index = detached_sessions[0].index
elif attached_sessions:
    index = attached_sessions[-1].index + 1
else:
    index=0
os.system("screen -RR login_%d -c ~/.env_setup/gnuscreen/screenrc_fend02_login" % index)
