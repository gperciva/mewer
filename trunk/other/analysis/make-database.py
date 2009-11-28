#!/usr/bin/env python
import numpy
import pylab
import glob
import sqlite3

def make_exercise_list():
	list = [];
	for i in range(4):
		for j in range(4):
			exercise = 'e' + str(i+1) + '_' + str(j+2)
			list.append(exercise)
	return list

exercise_list = make_exercise_list()

conn = sqlite3.connect('/tmp/markov.db')
c = conn.cursor()

table_init = 'create table data (skill int'
for e in exercise_list:
	table_init += ', ' + str(e) + ' int'
table_init += ')'

c.execute(table_init)


all = []
unskilled = []
amateur = []
expert = []
def make4list ():
	fill_list = []
	for j in range(4):
		fill_list.append( [] )
	return fill_list

for i in range(4):
	all.append(make4list())
	unskilled.append(make4list())
	amateur.append(make4list())
	expert.append(make4list())

# read inputs
for filename in glob.glob('data-*.txt'):
	user = filename[5:-4]
	filedata = open(filename).readlines()[0].split('\t')
	skill = filedata[1]
	insert = 'insert into data values (' + skill
	for p in range(4):
		phasedata = filedata[p+2]
		for e in range(4):
			exercisedata = phasedata[e]
			all[p][e].append( exercisedata )
			if (skill == '0'):
				unskilled[p][e].append( exercisedata )
			if (skill == '1'):
				amateur[p][e].append( exercisedata )
			if (skill == '2'):
				expert[p][e].append( exercisedata )
			insert += ', ' + str(exercisedata)
	insert += ')'
	print insert
	c.execute(insert)
conn.commit()

print "All responses:\t" + str(len(all[0][0]))
print "  Unskilled:\t" + str(len(unskilled[0][0]))
print "  Amateur:\t" + str(len(amateur[0][0]))
print "  Expert:\t" + str(len(expert[0][0]))

def write_tabulated_file (filename, list):
	file = open (filename, 'w')
	for i in range(4):
		combined = []
		file.write("Phase " + str(i+1) + "\n")
		for j in range(4):
			#arr = numpy.array(list[i][j], dtype=int)
			arr = numpy.array(list[i][j], dtype=float)
			label = "Exercise "+str(i+1)+"_"+str(j+2) 
			file.write("  "+label)
			file.write("\t %.2f" % arr.mean() + "\t %.2f" % numpy.median(arr) + "\t %.2f" % arr.std())
			file.write("    "+str(arr))
			file.write("\n")
			combined.append(arr)
		#pylab.figure()
		#pylab.boxplot(combined,1,'gD')
		#pylab.savefig(filename[:-3]+str(i)+'.png')
#		pylab.show()
	file.close()


#print all

# analyze
write_tabulated_file('all.txt', all)
write_tabulated_file('skill0.txt', unskilled)
write_tabulated_file('skill1.txt', amateur)
#write_tabulated_file('skill2.txt', expert)



