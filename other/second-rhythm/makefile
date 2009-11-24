all:
	./prep-rhythm.py ideal-1-0.exp 1
	./exp2wav.py 60 1-0.exp
	for f in ideal-1-[1-4].exp; do ./prep-rhythm.py $$f; done;
	for f in 1-[1-4].exp; do ./exp2wav.py 60 $$f; done;


clean:
	rm -f 1-?.wav

distclean: clean
	rm -f 1-?.exp

