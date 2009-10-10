#! /usr/bin/env python
import sys
import os
import Image
import ImageDraw
import glob

WIDTH = 400
HEIGHT = 50

scores = []
for exp in glob.glob('*.exp'):
	base = exp.split('-')[0]
	number = exp.split('-')[1].split('.')[0]
	print base
	print number
	image = Image.new('RGB', [WIDTH, HEIGHT], 'white')
	draw = ImageDraw.Draw(image)

	onsets = open(exp, 'r').readlines()
	for line in onsets:
		note = float(line.split()[0])
		time = float(line.split()[1])
		xpos = time * WIDTH / 8.0
		print xpos
		if (note>0):
			draw.line((xpos,0, xpos,HEIGHT),fill='blue')
	
	image_name = base+'-'+number+'.png'
	image.save(image_name, 'png')

