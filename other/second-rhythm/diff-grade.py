#! /usr/bin/env python
import sys
import os
import glob

try:
        perfect_name = sys.argv[1]
except:
        print "Please enter the perfect exercise filename"
        sys.exit(1)
try:
        attempt_name = sys.argv[2]
except:
        print "Please enter attempt basename"
        sys.exit(1)

def printList(list):
	for x in list: print "%0.2f" % (x),
	print ""


def getOnsetsAll(filename):
	list = []
	lines = open(filename, 'r').readlines()
	for line in lines:
		note = float(line.split()[0])
		time = float(line.split()[1])
		list.append(time)
	return list

def getDurs(list):
	durs = []
	for i in range(len(list)-1):
		diff = list[i+1] - list[i]
		durs.append(diff)
	return durs

def getRelative(list):
	accel = []
	for i in range(len(list)-1):
		acc = 0
		acc = list[i+1] - list[i]
		if (list[i] > 0):
			acc = list[i+1] / list[i]
		accel.append(acc)
	return accel

perfect = getOnsetsAll(perfect_name)
perfectDurs = getDurs(perfect)
perfectAccel = getRelative(perfectDurs)

scores = []
for i in range(2,6):
#   for level 4
#for i in [2, 4, 5, 3]:
	exp = attempt_name + '-' + str(i) + '.exp'
	base = exp.split('.')[0]

	onsets = getOnsetsAll(exp)
	onsetDurs = getDurs(onsets)
	onsetAccel = getRelative(onsetDurs)

	print "-----------"
	error = 0.0
	diffs = []
	abs_diffs = []
	errs = []
	for i in range(len(perfectDurs)-1):
		dur = perfectDurs[i]
		diff = onsetDurs[i] - perfectDurs[i]
		diffs.append(diff)
		abs_diff = onsets[i] - perfect[i]
		abs_diffs.append(abs_diff)

		late_penalty = 1
		# the note is late
		if (abs_diff > 0):
			late_penalty = 2
		#diff = diff/perfectDurs[i]
		#diff = diff/perfectDurs[i]
		err = abs(diff) / dur
		err *= late_penalty
		errs.append(err)
		error += 5*err
	acc_diffs = []
	for i in range(len(perfectAccel)-1):
		acc_diff = perfectAccel[i] - onsetAccel[i]
		acc_diffs.append(acc_diff)
	score = 100 - 10*error
	printList(abs_diffs)
	printList(perfectDurs)
	printList(onsetDurs)
	print "  ",
	printList(perfectAccel)
	print "  ",
	printList(onsetAccel)
	#printList(acc_diffs)
	#printList(diffs)
	#printList(errs)
	#print score

	scores.append(score)

#scores_file = open(attempt_name + '-scores.txt', 'w')
#for s in scores:
#	scores_file.write(s[0]+'\t')
#	scores_file.write(str(s[1])+'\n')
#scores_file.close()

print "-----------"
printList(scores)

