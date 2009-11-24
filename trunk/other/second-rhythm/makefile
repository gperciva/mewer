all:
	./prep-rhythm.py ideal-1-0.exp
	./exp2wav.py 60 1-0.exp
	for f in ideal-1-[1-4].exp; do ./prep-rhythm.py $$f 1; done;
	for f in 1-[1-4].exp; do ./exp2wav.py 60 $$f; done;


clean:
	rm -f 1-?.wav

