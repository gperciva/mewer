#!/usr/bin/python

print "BPM\tdelay"
#for bpm in range(60,121):
#	bps = 60.0 / bpm
#	bpms = bps * 1000
#	delay = (bpms/10.0) - 10
#	if (delay == int(delay)):
#		print str(bpm)+'\t',
#		print str(delay)
#print '*****'

for delay in range(40,91):
	bpms = (delay+10)*10
	bps = bpms / 1000.0
	bpm = 60.0 / bps
	checkbpm = bpm*1000
	if (checkbpm == int(checkbpm)):
		print str(bpm)+'\t'+str(delay)

