#! /usr/bin/env python
import sys
import os
import random
random.seed()

tolerances = [0.00, 0.02, 0.08, 0.13, 0.17]

inpositions_name = "easy.exp"
try:
        outfile_name = sys.argv[1]
except:
        print "Please enter output base filename"
        sys.exit(1)


print "Reading clap position file " + inpositions_name
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
		rand_abs = random.uniform(tol*3/4, tol)
		rand = random.choice([-1, 1]) * rand_abs
		newpos.append( pos + rand )
	shift = -1*newpos[0]
	for n in range(len(newpos)):
		newpos[n] += shift
	writePos(outfile_name+"-"+str(i)+".exp", newpos)

