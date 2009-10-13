import ui.UI;

class ListenRhythm {
	var level : Int;

	public function new() {
		level = 1;
		showMain();
	}

	function clicked(event : flash.events.MouseEvent) {
		trace("clicked");
	}

	function showLevel(event : flash.events.MouseEvent) {
		UI.clearScreen();

		var s:flash.display.MovieClip = flash.Lib.attach("foo-1-png");
		flash.Lib.current.addChild(s);

	}

	function showMain() {
		UI.clearScreen();

		var label = UI.label("Rhythmic Grading", 110, 20);
		flash.Lib.current.addChild(label);

		var rect = UI.button("foo", 50, 50, showLevel);
		flash.Lib.current.addChild(rect);
	}

	static function main() {
		new ListenRhythm();
	}
}

