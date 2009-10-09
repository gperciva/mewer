class MetroTest {
	// in seconds
	static var delay : Int;

	// in milliseconds
	static var initDelay : Float;
	static var worstDelay : Float;

	// in units
	static var beatCount : Int;
	static var totalBeats : Int;

	static var prev : Float;

	static function main() {
		delay = 50;
		totalBeats = 200;
		prev = 0;
		worstDelay = 0;
		initDelay = 0;

		// set up metronome
		for (i in 0...totalBeats) {
			haxe.Timer.delay( beat, i*delay);
		}
                // display end message
                haxe.Timer.delay( function(){ trace("done");},
                        (totalBeats+1)*delay);
	}

	static function beat() {
		var time : Float = haxe.Timer.stamp();
		if (prev == 0)
			prev = time;

		var thisDelay : Float = time - prev;
		prev = time;
		//trace(thisDelay);

		if (thisDelay > worstDelay) {
			worstDelay = thisDelay;
			trace("Worst metronome delay for "
				+ delay + " ms: "+(worstDelay*1000-delay)
				+ " ms");
		}
	}
}

