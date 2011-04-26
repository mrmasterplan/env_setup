import atexit
import os
import readline
import rlcompleter
import sys
histfile = os.path.join(os.environ["HOME"], ".pyhist")
try:
    readline.read_history_file(histfile)
except IOError:
    pass
readline.parse_and_bind('tab: complete')

atexit.register(readline.write_history_file, histfile)
del os, histfile
