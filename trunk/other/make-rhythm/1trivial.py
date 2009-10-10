#! /usr/bin/env python
import sys
import os
import random
random.seed()

tolerances = [0.05, 0.1, 0.2, 0.4]
try:
        inpositions_name = sys.argv[1]
except:
        print "Please enter input position filename"
        sys.exit(1)
try:
        outfile_name = sys.argv[2]
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
	file.write('0 8.0\n')
	file.close()


i = 1
for tol in tolerances:
	newpos = []
	for pos in positions:
		rand_abs = random.uniform(tol/2, tol)
		rand = random.choice([-1, 1]) * rand_abs
		newpos.append( pos + rand )
	shift = -1*newpos[0]
	for n in range(len(newpos)):
		newpos[n] += shift
	writePos(outfile_name+str(i)+".exp", newpos)
	i = i+1

i = 1
while (i < len(tolerances)+1):
	make_clap_command = "python make-clap.py "
	make_clap_command += outfile_name+str(i)+".exp "
	make_clap_command += outfile_name+str(i)+".wav "
	os.system(make_clap_command)
	i = i+1

