
all: compile.hxml
	echo *****  if this is the final build, Secret.hx  *****
	haxe compile.hxml
	cp listen-rhythm.html ~/public_html/
	cp listen-rhythm.swf ~/public_html/
	nekotools server

clean:
	rm listen-rhythm.swf

