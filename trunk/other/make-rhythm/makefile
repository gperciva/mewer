all:
	lilypond -dpreview trivial.ly
	mv trivial.preview.png 1-notation.png
	python trivial.py 1
	for f in *.exp; do python exp2wav.py $$f; done;
	for f in *.wav; do lame -b 64 $$f; done;
	python grade.py trivial.exp 1
	swfmill simple trivial.xml trivial.swf

clean:
	rm -f 1-* *.eps *.pdf *.swf scores.txt

