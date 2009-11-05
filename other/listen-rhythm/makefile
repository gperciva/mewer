
all: compile.hxml
	echo *****  if this is the final build, Secret.hx  *****
	haxe compile.hxml
	mkdir -p ~/public_html/
	cp listen-rhythm.html ~/public_html/
	cp listen-rhythm.swf ~/public_html/
	#
	mkdir -p ~/public_html/cgi-bin/
	cp survey.py ~/public_html/cgi-bin/
	chmod a+x ~/public_html/cgi-bin/survey.py
	chgrp www-data ~/public_html/cgi-bin/
	chmod g+w ~/public_html/cgi-bin/

clean:
	rm -f listen-rhythm.swf remoting.n
	rm -f nekoserver/*

