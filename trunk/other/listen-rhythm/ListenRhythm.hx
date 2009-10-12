class ListenRhythm {

	public function new() {
		showMain();
	}

	function showMain() {
		var tf = new flash.text.TextField();
		tf.text = "Rhythmic Grading";
		tf.x = 110;
		tf.y = 20;
		flash.Lib.current.addChild(tf);

	}

	static function main() {
		new ListenRhythm();
/*
		showMain();
		trace("foo");

        var s:flash.display.MovieClip = flash.Lib.attach("foo-1-png");
        flash.Lib.current.addChild(s);
*/
	}

}

