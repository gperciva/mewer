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
	sys.exit(1)
try:
	add_metro = int(sys.argv[3])
except:
	print "Add a metronome or not?"
	sys.exit(1)

beat_samples = 44100.0 / (60.0/tempo)
if (add_metro == 1):
	outfile_name = inpositions_name[:-4] + ".wav"
else:
	outfile_name = inpositions_name[:-4] + "-no-metro.wav"


#print "Reading clap position file " + inpositions_name
positions = open(inpositions_name, 'r').readlines()

#print "Reading input clap file " + inclap_name
inclap_file = wave.open(inclap_name, 'rb')
clap = inclap_file.readframes(4410)
clap_list = list(struct.unpack(str(len(clap)/2)+'h', clap))
inclap_file.close()

metro_dur = 441
inmetro_high_file = wave.open('metro-high.wav', 'rb')
metro_high = inmetro_high_file.readframes(4410)
metro_high_list = list(struct.unpack(str(len(metro_high)/2)+'h', metro_high))
inmetro_high_file.close()

inmetro_low_file = wave.open('metro-low.wav', 'rb')
metro_low = inmetro_low_file.readframes(4410)
metro_low_list = list(struct.unpack(str(len(metro_low)/2)+'h', metro_low))
inmetro_low_file.close()



def silenceSamples(samples):
	fill_zeros = []
	for i in range(int(samples)):
		fill_zeros.append(0)
	return fill_zeros


# two bars of 4/4 time
if (add_metro ==1):
	metronome = []
	for bar in range(2):
		metronome.extend(metro_high_list)
		metronome.extend(silenceSamples(beat_samples - metro_dur))
		for offbeat in range(3):
			metronome.extend(metro_low_list)
			metronome.extend(silenceSamples(beat_samples - metro_dur))

claps = []
now = 0
adjust = -9
for line in positions:
	splitline = line.split()
	note = float(line.split()[0])
	time = float(line.split()[1])
	if (adjust == -9):
		if (add_metro == 1):
			adjust = 0
		else:
			adjust = 0.25 - time
	time = time + adjust

	if (note > 0):
		num_zeros = int( 44100.0*(time-now))
		if (num_zeros > 0):
			claps.extend(silenceSamples(num_zeros))
		now = time
		claps.extend(clap_list)
		now += 0.1   # length of clap
if (add_metro == 1):
	# fill remainder with zeros
	remaining_zeros = len(metronome) - len(claps)
	if (remaining_zeros < 0):
		print "ERROR: claps exceed a bar!"
		sys.exit()
	if (remaining_zeros > 0):
		claps.extend(silenceSamples(remaining_zeros))


audioframes = ''
# mix them together
size = len(claps)
for i in range(size):
	if (add_metro == 1):
		sum = metronome[i] + claps[i]
	else:
		sum = claps[i]
	if (sum > SHRT_MAX):
		sum = SHRT_MAX
	if (sum < SHRT_MIN):
		sum = SHRT_MIN
	audioframes += struct.pack('h',sum)

print "Writing output file " + outfile_name
out_file = wave.open(outfile_name, 'wb')
out_file.sr = 44100
out_file.setparams((1, 2, 44100, 44100*4, 'NONE', 'noncompressed'))
out_file.writeframes(audioframes)
out_file.close()



