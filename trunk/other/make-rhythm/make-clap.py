#! /usr/bin/env python
import wave
import sys
import struct

inclap_name = "clap.wav"
try:
	inpositions_name = sys.argv[1]
except:
	print "Please enter input position filename"
	sys.exit(1)
try:
	outfile_name = sys.argv[2]
except:
	print "Please enter output filename"
	sys.exit(1)


print "Reading clap position file " + inpositions_name
positions = open(inpositions_name, 'r').readlines()

print "Reading input clap file " + inclap_name
inclap_file = wave.open(inclap_name, 'rb')
clap = inclap_file.readframes(4410)
inclap_file.close()

print "Writing output file " + outfile_name
out_file = wave.open(outfile_name, 'wb')
out_file.sr = 44100
out_file.setparams((1, 2, 44100, 44100*4, 'NONE', 'noncompressed'))

# initial silence; currently needed in MEAWS
fill_zeros = ''
for i in range( 22050 ):
	fill_zeros += struct.pack('h', 0)
out_file.writeframes(fill_zeros)

now = 0
for line in positions:
	splitline = line.split()
	note = float(line.split()[0])
	time = float(line.split()[1])

	# fill zeros
	fill_zeros = ''
	num_zeros = int( 44100.0*(time-now))
	if (num_zeros > 0):
		for i in range( num_zeros ):
			fill_zeros += struct.pack('h', 0)
		out_file.writeframes(fill_zeros)
		now = time
	if (note > 0):
		out_file.writeframes(clap)
		now += 0.1   # length of clap


out_file.close()


