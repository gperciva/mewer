import ui.UI;

class ListenRhythm {
	var level : Int;

	public function new() {
		level = 1;
		showMain();
	}

	function clicked(event : flash.events.MouseEvent) {
		trace(event);
	}

	function clickedTry(event : flash.events.MouseEvent) {
		var name: String = event.target.name;
//		trace(name);

		//var sound:flash.media.Sound;
		//sound = flash.media.Sound.attach(name+"-mp3");
		//trace(sound.length);
		//sound.play();

    var URL = "http://localhost:2000/remoting.n";
    var cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
    cnx.setErrorHandler( function(err) trace("Error: "+Std.string(err)) );
    cnx.Server.record.call([1], display);
	}

	static function display(v) {
		trace(v);
	}

	function setupTry(number: Int) {
		var name:String;
		name = "1-" + number;
		var s:flash.display.Sprite = flash.Lib.attach(name+"-png");
		s.name = name; 
		s.width = 400;
		s.y = 60*(number-1);

		s.addEventListener(flash.events.MouseEvent.MOUSE_UP, clickedTry);
		flash.Lib.current.addChild(s);
	}


	function showLevel(event : flash.events.MouseEvent) {
		UI.clearScreen();

		for (i in 1...5) {
			setupTry(i);
		}
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

