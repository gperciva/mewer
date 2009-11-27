#!/usr/bin/env python
import sys
import numpy

bpm = int(sys.argv[1])

claps_file_lines = open('claps'+str(bpm)+'.txt').readlines()
claps_list = []
for line in claps_file_lines:
	claps_list.append( float(line) )

diffs = []
prev = -1
for c in claps_list:
	if (prev > 0):
		diff = prev - c
		diff += 60.0 / bpm
		diff *= 1000.0
		if (diff > 50):
			print "SUSPICIOUS: error > 50ms"
		diffs.append(diff)
	prev = c

# omit first and last
arr = numpy.array(diffs[1:-1])

print arr

print "mean:\t", numpy.mean(arr), " ms"
print "median:\t", numpy.median(arr), "ms"
print "std:\t", arr.std(), "ms"


