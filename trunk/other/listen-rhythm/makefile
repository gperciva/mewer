
all: compile.hxml
	echo *****  if this is the final build, Secret.hx  *****
	haxe compile.hxml
	cp listen-rhythm.html ~/public_html/
	cp listen-rhythm.swf ~/public_html/
	#
	mkdir -p nekoserver/
	cp remoting.n nekoserver/
	cd nekoserver && nekotools server

clean:
	rm -f listen-rhythm.swf remoting.n
	rm -f nekoserver/*

