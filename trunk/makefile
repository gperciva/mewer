
all: compile.hxml main.hx
	mkdir -p out
	haxe compile.hxml
	cp html/* out/
	cp *.swf ~/Sites/
	cp *.js ~/Sites/

install:
	cp -r metro ~/Sites/
	cp -r data ~/Sites/

clean:
	rm -f mewer.swf mewer.js extraMetro.js

