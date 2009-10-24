all:
	lilypond -dpreview trivial.ly
	mv trivial.preview.png 1-notation.png
	python trivial.py 1
	python grade.py trivial.exp 1
	#
	lilypond -dpreview easy.ly
	mv easy.preview.png 2-notation.png
	python easy.py 2
	python grade.py easy.exp 2
	#
	#
	for f in *.exp; do python exp2wav.py $$f; done;
	for f in *.wav; do lame -b 64 $$f; done;
	swfmill simple phases.xml phases.swf

clean:
	rm -f *.eps *.pdf *.swf
	rm -f 1-* trivial.wav*
	rm -f 2-* easy.wav*

