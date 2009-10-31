#!/usr/bin/python
import cgi
import time

num_phases = 4
num_fields = 2 + num_phases

def sorry():
	print "Sorry, a nework error has occurred."

def verify_write(form):
	if (len(form) != num_fields):
		sorry()
	log_line = str( int( form["skill"].value )) + '\t'
	log_line += str( int( form["1"].value )) + '\t'
	log_line += str( int( form["2"].value )) + '\t'
	log_line += str( int( form["3"].value )) + '\t'
	log_line += str( int( form["4"].value )) + '\t'
	write_log(log_line)

def write_log(log_line):
	outfilename = "data-"+str(int(time.time()))+".txt"
	outfile = open(outfilename,'a')
	outfile.write(log_line)
	outfile.close()
	print "written"


def main():
	print "Content-type: text/html\n"
	form = cgi.FieldStorage()
	if not form:
		sorry()
	elif form.has_key("ping"):
		if (form["ping"].value == '1'):
			print "pong"
	elif form.has_key("action"):
		if (form["action"].value == 'record'):
			verify_write(form)
	else:
		sorry()

main()

