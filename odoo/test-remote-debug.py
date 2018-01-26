#!/usr/bin/python
import sys
import pydevd

print 'Try to connect to ' + sys.argv[1] + ':' + sys.argv[2] + ' ...'

pydevd.settrace(sys.argv[1], port=int(sys.argv[2]), stdoutToServer=True, stderrToServer=True)

print 'Successfully connected :)'