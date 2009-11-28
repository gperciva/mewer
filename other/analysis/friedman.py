#!/usr/bin/env python
from scipy import stats
import numpy

def friedman(matrix):
	ranked = numpy.array(matrix, dtype='f')
	for row in range(len(matrix)):
		rank = stats.rankdata( matrix[row] )
		ranked[row] = rank
#	print ranked

	# algorithm + variable names from
	# http://faculty.vassar.edu/lowry/ch15a.html
	k = len(ranked[0])
	n = len(ranked)

	T = []
	M = []
	Tall = 0.0
	Mall = 0.0
	for col in range(len(ranked[0])):
		sum = 0.0
		for i in range(len(ranked)):
			sum += ranked[i][col]
		mean = sum / len(ranked)
		T.append(sum)
		M.append(mean)
		Tall += sum
	Mall = Tall / ( len(ranked) * len(ranked[0]))

#	print T
#	print M
#	print Tall, n*k*(k+1)/2.0
#	print Mall, (k+1)/2.0

	SSbgr = 0.0
	for g in range(k):
		diff = (M[g] - Mall)
		diff = diff*diff
		diff = n * diff
		SSbgr += diff
#	print SSbgr

	df = k-1
	chiSquared = SSbgr / (k * (k+1) / 12.0)

#	print chiSquared
	prob = stats.chisqprob(chiSquared, df)
#	print prob

	return chiSquared, prob, M



