# for osx
BUILDDIR = ~/Sites/

all: compile.hxml Main.hx
	mkdir -p out
	haxe compile.hxml
	cp out/* ${BUILDDIR}
	cp html/* ${BUILDDIR}

install: all
	mkdir -p ${BUILDDIR}/metro
	cd buildmetro && sh dometro.sh ${BUILDDIR}/metro
	#cp -r data ~/Sites/

clean:
	rm -rf out/

