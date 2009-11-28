#!/usr/bin/env python
import sqlite3
from scipy import stats
import Bio.Cluster
import friedman

P_VALUE_DIGITS = 5

conn = sqlite3.connect('/tmp/markov.db')
c = conn.cursor()

#c.execute('select * from data order by skill')
#for row in c:
#	print row

def printList(list, digits=2):
        for x in list: print ("%0."+str(digits)+"f" )% (x),
        print ""

def exercise(one, two):
	return 'e' + str(one) + '_' + str(two)

def make_exercise_list():
	list = [];
	for i in range(4):
		for j in range(4):
			exercise_text = exercise(i+1, j+2)
			list.append(exercise_text)
	return list

def cmp(one, op, two, skill = -1):
	where = 'where (%(one)s %(op)s %(two)s)'
	if (skill >=0):
		where += 'AND (skill = %(skill)s)'

	query_string = ('''
		select skill,%(one)s,%(two)s
		from data ''' +
		where ) % locals()
	#query = c.execute(query_string,(exercise_one,exercise_two)).fetchall()
	query = c.execute(query_string).fetchall()
	#print query
	return len(query)

def compare(exercise_one, exercise_two, skill=-1):
	print exercise_one + ' vs. ' + exercise_two,
	print '\t > ' + str(cmp(exercise_one, '>', exercise_two, skill)),
	print '\t = ' + str(cmp(exercise_one, '=', exercise_two, skill)),
	print '\t < ' + str(cmp(exercise_one, '<', exercise_two, skill)),
	print ''


def exercise_level(e, skill = -1):
	for j in range(4):
		for k in range(3-j):
			one = exercise(e, j+2)
			two = exercise(e, k+j+3)
			compare(one, two, skill)

def totalComparisons():
	for i in range(4):
		l = i+1
		print "*** level " + str(l)
		print "  all"
		exercise_level(l)
		print "  skilled"
		exercise_level(l,1)
		print "  unskilled"
		exercise_level(l,0)

# this is horrible, but it's good enough so shut up
def printSortedRanks(list):
	# insert sort for teh win!
	result = ''
	for i in range(4):
		value = -1
		pos = -1
		for j in range(4):
			if (value < list[j]):
				value = list[j]
				pos = j
		result += str(pos+2)
		list[pos] = -1
	print result,


def makeRanking(level, skill):
	exercises = ''
	for i in range(4):
		exercises += exercise(level,i+2)
		if (i<3):
			exercises += ', '
	query_string = ('''
		select %(exercises)s
		from data
		where skill = %(skill)s
		''') % locals()
	query = c.execute(query_string).fetchall()
	chi_square, p_value, means = friedman.friedman(query)
	print ("p_value: %."+str(P_VALUE_DIGITS)+"f") % p_value,
	print "\tmean rankings: ",
	printList(means,1)


def individualRankings():
	for i in range(4):
		print "Level " + str(i+1)
		print "   skilled"
		print "      ",
		makeRanking(i+1,1)
		print "   unskilled"
		print "      ",
		makeRanking(i+1,0)


#totalComparisons()

individualRankings()

conn.close()

