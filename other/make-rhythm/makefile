all:
	lilypond -dpreview trivial.ly
	mv trivial.preview.png 1-notation.png
	python trivial.py 1
	python grade.py trivial.exp 1
	#
	lilypond -dpreview 2-notation.ly
	mv 2-notation-preview.png 2-notation.png
	python easy.py 2
	python grade.py easy.exp 2
	#
	lilypond -dpreview 3-notation.ly
	mv 3-notation.preview.png 3-notation.png
	python grade.py 3-1.exp 3
	#
	lilypond -dpreview 4-notation.ly
	mv 4-notation.preview.png 4-notation.png
	python grade.py 4-1.exp 4
	#
	#
	for f in *.exp; do python exp2wav.py $$f; done;
	for f in *.wav; do lame -b 64 $$f; done;
	swfmill simple phases.xml phases.swf

clean:
	rm -f *.eps *.pdf *.swf *.png clap.wav.mp3
	rm -f 1-* trivial.wav*
	rm -f 3-*.wav* 4-*.wav* 2-*.wav*
	rm -f 2-scores.txt 3-scores.txt 4-scores.txt

