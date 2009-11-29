#! /usr/bin/env python
import sys
import os
import Image
import ImageDraw

WIDTH = 300
X_OFFSET = 32
HEIGHT = 50
ERROR_SCALE = 500.0

try:
        filename = sys.argv[1]
except:
        print "Please enter the filename"
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

onsets = getOnsets(filename)
base = filename.split('.')[0]

# draw png
image = Image.new('RGB', [WIDTH, HEIGHT], 'white')
draw = ImageDraw.Draw(image)
offset = -onsets[0]
for o in onsets:
	xpos = (o + offset) * (WIDTH-X_OFFSET) / 4.0 + X_OFFSET
	print xpos
	draw.line((xpos,0, xpos,HEIGHT),fill='blue')
	draw.line((xpos+1,0, xpos+1,HEIGHT),fill='blue')
image.save(base+'.png', 'png')


