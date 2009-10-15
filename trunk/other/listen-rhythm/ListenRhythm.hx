//import ui.UI;

class ListenRhythm {
	var ui : ui.UI;
	var cnx : haxe.remoting.HttpAsyncConnection;
	var phase : Int;

	var attempt : Array<Attempt>;
	var results : Array<Array<Int>>;

	public function new() {
		phase = 0;
		results = new Array();

		ui = new ui.UI(flash.Lib.current);
		ui.showMain(showLevel);
	}

/*
	function clickedTry(event : flash.events.MouseEvent) {
		var name: String = event.target.name;
		var choice:Int = Std.parseInt( name.split('-')[1] );

		//var sound:flash.media.Sound;
		//sound = flash.media.Sound.attach(name+"-mp3");
		//trace(sound.length);
		//sound.play();

		cnx.Server.record.call([choice], display);
	}

	static function display(v) {
		if (v==0)
			return;
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
*/

	function showLevel() {
		phase++;
		attempt = new Array();

		// randomize order
		var order : Array<Int> = new Array();
		while (order.length < 4) {
			var tryInt : Int = Std.random(4) + 1;
			for (i in 0...4) {
				if (order[i] == tryInt) {
					tryInt = 0;
				}
				if (order[i] == 0) {
					order[i] = tryInt;
					tryInt = 0;
				}
				if (tryInt == 0) {
					break;
				}
			}
		}

		for (i in 0...4) {
			attempt[i] = new Attempt(phase, order[i], stopSounds);
		}

		ui.showLevel(attempt);

/*
		var URL = "http://localhost:2000/remoting.n";
		cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
		cnx.setErrorHandler( function(err) trace("Error: "+Std.string(err)) );
*/
	}

	function stopSounds() {
		for (i in 0...4) {
			attempt[i].stopPlay();
		}
	}


	static function main() {
		new ListenRhythm();
	}
}

