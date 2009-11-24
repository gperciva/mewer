#! /usr/bin/env python
import sys
import os
import random
random.seed()

tolerances = [20, 60, 100, 140] # in milliseconds

inpositions_name = "ideal-1-0.exp"
outfile_name = "ideal-1"

positions_read = open(inpositions_name, 'r').readlines()

positions = []
for line in positions_read:
	splitline = line.split()
	note = float(splitline[0])
	time = float(splitline[1])
	if (note > 0):
		positions.append(time)

def writePos(filename, positions):
	file = open(filename, 'w')
	for p in positions:
		file.write('60 ' + str(p) + '\n')
	file.write('0 4.0\n')
	file.close()


for j in range(len(tolerances)):
	tol = tolerances[j]
	i = j+1
	newpos = []
	for pos in positions:
		rand_abs = random.uniform(tol*3/4, tol) / 1000.0
		rand = random.choice([-1, 1]) * rand_abs
#		print pos, rand, pos+rand
		newpos.append( pos + rand )
#	print "-----------"
	writePos(outfile_name+"-"+str(i)+".exp", newpos)


