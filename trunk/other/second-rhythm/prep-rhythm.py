#! /usr/bin/env python
import sys

tolerance = 20  # in milliseconds
try:
	inpositions_name = sys.argv[1]
except:
	print "Please enter input position filename"
	sys.exit(1)
if (len(sys.argv) > 2):
	no_change = 1
else:
	no_change = 0

positions = open(inpositions_name, 'r').readlines()

out_file = open(inpositions_name[6:], 'w')

for line in positions:
	splitline = line.split()
	note = float(line.split()[0])
	time = float(line.split()[1])

	if no_change:
		newtime = time + 4.0
		changed_line = str(int(note)) + ' ' + str(newtime) + '\n'
	else:
		import random
		random.seed()
		rand_abs = random.uniform(tolerance*3/4, tolerance)/1000.0
		rand = random.choice([-1,1]) * rand_abs
		newtime = time + 4.0 + rand
		changed_line = str(int(note)) + ' ' + str(newtime) + '\n'
	out_file.write(changed_line)

out_file.close()


