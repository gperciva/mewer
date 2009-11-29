
all: compile.hxml
	echo *****  if this is the final build, secret in Config.hx  *****
	haxe compile.hxml
	mkdir -p ~/public_html/
	cp index.html ~/public_html/
	cp listen-rhythm.swf ~/public_html/
	#
	mkdir -p ~/public_html/cgi-bin/
	cp survey.py ~/public_html/cgi-bin/
	#
	for i in A B C D E F G; do haxe -D $$i compile.hxml; \
		cp listen-rhythm.swf ~/public_html/listen-rhythm$$i.swf; \
		cp index.html ~/public_html/index$$i.html; \
		sed -i "s/listen-rhythm/listen-rhythm$$i/" \
			~/public_html/index$$i.html; \
		cp survey.py ~/public_html/cgi-bin/survey$$i.py; \
		sed -i "s/base = 'data'/base = '$$i'/" \
			~/public_html/cgi-bin/survey$$i.py; \
		done
	#
	chmod a+x ~/public_html/cgi-bin/*.py
	chgrp www-data ~/public_html/cgi-bin/
	chmod g+w ~/public_html/cgi-bin/

clean:
	rm -f listen-rhythm.swf remoting.n

