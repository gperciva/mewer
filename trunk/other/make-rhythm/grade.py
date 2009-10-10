#! /usr/bin/env python
import sys
import os
import Image
import ImageDraw
import glob

WIDTH = 400
HEIGHT = 50

try:
        perfect_name = sys.argv[1]
except:
        print "Please enter perfect exercise filename"
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
	for i in len(list):
		delta = abs(list[i] - value)
		if (delta < bestDelta):
			bestDelta = delta
	return bestDelta

def gradeExercise(perfect, exercise, offset):
	error = 0.0
	for line in perfect:
		note = float(line.split()[0])
		if (note==0):
			continue
		time = float(line.split()[1])
		noteError = findNearest(exercise, time-offset)

	for line in exercise:
		print foo


perfect = getOnsets(perfect_name)

scores = []
for exp in glob.glob('*-*.exp'):
	base = exp.split('-')[0]
	number = exp.split('-')[1].split('.')[0]

	onsets = getOnsets(exp)

	averageOnsets = float(sum(onsets)) / len(onsets)
	averagePerfect = float(sum(perfect)) / len(perfect)
	offset = averagePerfect - averageOnsets

	# draw png
	image = Image.new('RGB', [WIDTH, HEIGHT], 'white')
	draw = ImageDraw.Draw(image)
	for o in onsets:
		xpos = (o + offset) * WIDTH / 8.0
		draw.line((xpos,0, xpos,HEIGHT),fill='blue')
	image_name = base+'-'+number+'.png'
	image.save(image_name, 'png')


	sys.exit(1)
	gradeExercise(perfect, onsets, offset)



