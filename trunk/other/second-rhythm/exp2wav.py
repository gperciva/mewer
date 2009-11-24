#! /usr/bin/env python
import wave
import sys
import struct
SHRT_MAX = 32767
SHRT_MIN = -32768

inclap_name = "clap.wav"
try:
	tempo = float(sys.argv[1])
except:
	print "Please enter the tempo (in BPM)"
	sys.exit(1)
try:
	inpositions_name = sys.argv[2]
except:
	print "Please enter input position filename"
	sys.exit(2)

beat_samples = 44100.0 / (60.0/tempo)
outfile_name = inpositions_name[:-4] + ".wav"


#print "Reading clap position file " + inpositions_name
positions = open(inpositions_name, 'r').readlines()

#print "Reading input clap file " + inclap_name
inclap_file = wave.open(inclap_name, 'rb')
clap = inclap_file.readframes(4410)
inclap_file.close()

metro_dur = 441
inmetro_high_file = wave.open('metro-high.wav', 'rb')
metro_high = inmetro_high_file.readframes(4410)
inmetro_high_file.close()

inmetro_low_file = wave.open('metro-low.wav', 'rb')
metro_low = inmetro_low_file.readframes(4410)
inmetro_low_file.close()


print "Writing output file " + outfile_name
out_file = wave.open(outfile_name, 'wb')
out_file.sr = 44100
out_file.setparams((1, 2, 44100, 44100*4, 'NONE', 'noncompressed'))


def silenceSamples(samples):
	fill_zeros = ''
	for i in range(int(samples)):
		fill_zeros += struct.pack('h', 0)
	return fill_zeros


# two bars of 4/4 time
metronome = ''
for bar in range(2):
	metronome += metro_high
	metronome += silenceSamples(beat_samples - metro_dur)
	for offbeat in range(3):
		metronome += metro_low
		metronome += silenceSamples(beat_samples - metro_dur)

claps = ''
now = 0
for line in positions:
	splitline = line.split()
	note = float(line.split()[0])
	time = float(line.split()[1])

	if (note > 0):
		num_zeros = int( 44100.0*(time-now))
		if (num_zeros > 0):
			claps += silenceSamples(num_zeros)
		now = time
		claps += clap
		now += 0.1   # length of clap
# fill remainder with zeros
remaining_zeros = (len(metronome) - len(claps))/2
if (remaining_zeros < 0):
	print "ERROR: claps exceed a bar!"
	sys.exit()
if (remaining_zeros > 0):
	claps += silenceSamples(remaining_zeros)


# mix them together
audioframes = ''
size = len(metronome)/2
metro_values = struct.unpack(str(size)+'h', metronome)
clap_values = struct.unpack(str(size)+'h', claps)
for i in range(size):
	sum = metro_values[i] + clap_values[i]
	if (sum > SHRT_MAX):
		sum = SHRT_MAX
		print "clipping"
	if (sum < SHRT_MIN):
		sum = SHRT_MIN
		print "clipping"
	audioframes += struct.pack('h',sum)
	
out_file.writeframes(audioframes)


