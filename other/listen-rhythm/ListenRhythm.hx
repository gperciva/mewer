import ui.UI;

class ListenRhythm {

	public function new() {
		showMain();
	}

	function clicked(event : flash.events.MouseEvent) {
		trace("clicked");
	}

	function showMain() {
		var label = UI.label("Rhythmic Grading", 110, 20);
		flash.Lib.current.addChild(label);

		var rect = UI.button("foo", 50, 50, clicked);
		flash.Lib.current.addChild(rect);
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

