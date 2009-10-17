all:
	lilypond -dpreview trivial.ly
	mv trivial.preview.png 1-notation.png
	python trivial.py 1
	python grade.py trivial.exp 1
	swfmill simple trivial.xml trivial.swf

clean:
	rm -f 1-* *.eps *.pdf *.swf scores.txt

