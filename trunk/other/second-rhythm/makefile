all:
	lilypond -dpreview ideal-1-0.ly
	mv ideal-1-0.preview.png 1-notation.png
	lilypond -dpreview ideal-2-0.ly
	mv ideal-2-0.preview.png 2-notation.png
	lilypond -dpreview ideal-3-0.ly
	mv ideal-3-0.preview.png 3-notation.png
	lilypond -dpreview ideal-4-0.ly
	mv ideal-4-0.preview.png 4-notation.png
	lilypond -dpreview ideal-5-0.ly
	mv ideal-5-0.preview.png 5-notation.png
	#
	for f in ideal-[1-5]-0.exp; do ./prep-rhythm.py $$f 1; done;
	for f in ideal-[1-5]-[1-4].exp; do ./prep-rhythm.py $$f; done;
	for f in [1-5]-0.exp; do ./exp2png.py $$f; done;
	#
	for f in [1-5]-*.exp; do ./exp2wav.py 60 $$f 1; done;
	for f in [1-5]-*.wav; do lame -b 64 $$f; done;
	#
	rm -f *.eps *.pdf
	swfmill simple phases.xml phases.swf

clean:
	rm -f [1-5]-*.wav [1-5]-*.mp3
	rm -f *.png
	rm -f phases.swf

distclean: clean
	rm -f [1-5]-?.exp

