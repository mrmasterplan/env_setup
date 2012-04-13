#!/usr/bin/env python


def main():
    import os, sys, re, commands, time
    t0 = time.time()
    
    screenls = commands.getoutput("screen -ls")
    print screenls
    
    waitforsimilar()
    while time.time()-t0<2:
            time.sleep(0.1)
    
    newscreenls = commands.getoutput("screen -ls")
    if newscreenls!= screenls:
        # t0 = time.time()
        print newscreenls
        screenls = newscreenls
    
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
    
    command="screen %s -RR %s%d"%(screenrc,base_name,index)
    # pass control to screen:
    os.execvp("screen",command.split())


def waitforsimilar():
    import os, commands, re, time, random
    mypid = os.getpid()
    
    pspat = re.compile(r""" *(?P<pid>\d+) +(((?P<days>\d+)-)?(?P<hours>\d{2}):)?(?P<time>\d{2}:\d{2}) (?P<command>.*)""")
    
    match=pspat.search(commands.getoutput("ps xo pid,etime,command -p %d"%mypid))
    mycommand = hash(match.group("command"))
    mytime = makefloattime(match)
    
    lastbbs=[]
    lastequals=[]
    waited=0
    patience=2.
    step=0.2
    while 1:
        bbs=[]
        equals=[]
        psout = commands.getoutput("ps axo pid,etime,command")
        # print psout
        mytime = makefloattime(re.search(r""" *%d +(((?P<days>\d+)-)?(?P<hours>\d{2}):)?(?P<time>\d{2}:\d{2}) (?P<command>.*)"""%(mypid),psout))
        for match in pspat.finditer(psout):
            if hash(match.group("command")) == mycommand:
                pid=int(match.group("pid"))
                if pid==mypid:
                    continue
                if makefloattime(match) > mytime:
                    # print "Found bb:"
                    # print match.group(0)
                    bbs=1
                    break
                if makefloattime(match) == mytime:
                    # print "Found equal:"
                    # print match.group(0)
                    
                    equals+=[pid]
        # found the list of big brothers.
        if bbs:
            time.sleep(step)
            continue
        if equals:
            if set(equals) != set(lastequals):
                lastequals=equals
                time.sleep(step)
                continue
            else:
                #we are waiting for the same equals as last time.
                # get impatient.
                if random.random()<0.1:
                    return
        return

def makefloattime(match):
    time = 60. * int(match.group("time")[:2]) + int(match.group("time")[-2:])
    if match.group("days"):
        time+=3600.*24*int(match.group("days"))
    if match.group("hours"):
        time+=3600. * int(match.group("hours"))
    return time

main()