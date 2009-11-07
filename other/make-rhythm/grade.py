#! /usr/bin/env python
import sys
import os
import Image
import ImageDraw
import glob

WIDTH = 323
X_OFFSET = 32
HEIGHT = 50
ERROR_SCALE = 500.0

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


def getOnsets(filename):
	list = []
	lines = open(filename, 'r').readlines()
	for line in lines:
		note = float(line.split()[0])
		if (note > 0):
			time = float(line.split()[1])
			list.append(time)
	return list


def findNearest(list, value):
	bestDelta = abs(float(list[0]) - value)
	for i in range(len(list)):
		delta = abs(list[i] - value)
		if (delta < bestDelta):
			bestDelta = delta
	return bestDelta

def gradeExercise(perfect, exercise, offset):
	error = 0.0
	for time in perfect:
		noteError = findNearest(exercise, time-offset)
		noteError = noteError * noteError
		error += noteError
	for time in exercise:
		noteError = findNearest(perfect, time+offset)
		noteError = noteError * noteError
		error += noteError
	error = error*ERROR_SCALE
	grade = 100 - error
	if (grade<0):
		grade = 0
	return grade


perfect = getOnsets(perfect_name)

scores = []
for i in range(1,6):
	exp = attempt_name + '-' + str(i) + '.exp'
	base = exp.split('.')[0]

	onsets = getOnsets(exp)

	averageOnsets = float(sum(onsets)) / len(onsets)
	averagePerfect = float(sum(perfect)) / len(perfect)
	offset = averagePerfect - averageOnsets

	# draw png
	image = Image.new('RGB', [WIDTH, HEIGHT], 'white')
	draw = ImageDraw.Draw(image)
	for o in onsets:
		xpos = (o + offset) * (WIDTH-X_OFFSET) / 4.0 + X_OFFSET
		draw.line((xpos,0, xpos,HEIGHT),fill='blue')
		draw.line((xpos+1,0, xpos+1,HEIGHT),fill='blue')
	image.save(base+'.png', 'png')

	grade = gradeExercise(perfect, onsets, offset)
	scores.append([base, grade])

scores_file = open(attempt_name + '-scores.txt', 'w')
for s in scores:
	scores_file.write(s[0]+'\t')
	scores_file.write(str(s[1])+'\n')
scores_file.close()

print scores
