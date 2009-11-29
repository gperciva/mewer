all:
	./prep-rhythm.py ideal-1-0.exp 1
	./exp2wav.py 60 1-0.exp 1
	./exp2png.py 1-0.exp
	lilypond -dpreview ideal-1-0.ly
	mv ideal-1-0.preview.png 1-notation.png
	#
	for f in ideal-*.exp; do ./prep-rhythm.py $$f; done;
	for f in [1-5]-*.exp; do ./exp2wav.py 60 $$f 1; done;
	for f in [1-5]-*.wav; do lame -b 64 $$f; done;
	#
	#
	swfmill simple phases.xml phases.swf

clean:
	rm -f 1-*.wav
	rm -f *.eps *.pdf

distclean: clean
	rm -f 1-?.exp

