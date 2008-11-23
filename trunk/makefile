
all: compile.hxml main.hx
	haxe compile.hxml
	cp *.html ~/Sites/
	cp *.swf ~/Sites/
	cp *.js ~/Sites/

install:
	cp -r metro ~/Sites/
	cp -r data ~/Sites/

clean:
	rm -f mewer.swf mewer.js extraMetro.js

