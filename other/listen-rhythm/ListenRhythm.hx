
class ListenRhythm {
	static inline var MAX_PHASE = 1;

	var ui : ui.UI;
	var cnx : haxe.remoting.HttpAsyncConnection;
	var phase : Int;

	var attempt : Array<Attempt>;
	var results : Array<Array<Int>>;

	public function new() {
		phase = 0;
		results = new Array();

		ui = new ui.UI(flash.Lib.current);
		ui.showMain(advanceLevel);
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
		s.width = 300;
		s.y = 40*(number-1);

		s.addEventListener(flash.events.MouseEvent.MOUSE_UP, clickedTry);

		flash.Lib.current.addChild(s);
	}
*/

	function advanceLevel() {
		phase++;
		if (phase > MAX_PHASE) {
			finalPhase();
			return;
		}

		attempt = new Array();

		// randomize order
		var order : Array<Int> = new Array();
		while (order.length < 4) {
			var tryInt : Int = Std.random(4) + 2;
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

		attempt[0] = new Attempt(phase, 1, stopSounds);
		for (i in 0...4) {
			attempt[i+1] = new Attempt(phase, order[i], stopSounds);
		}

		ui.showLevel(phase, MAX_PHASE, attempt, advanceLevel);

/*
		var URL = "http://localhost:2000/remoting.n";
		cnx = haxe.remoting.HttpAsyncConnection.urlConnect(URL);
		cnx.setErrorHandler( function(err) trace("Error: "+Std.string(err)) );
*/
	}

	function finalPhase() {
		ui.showFinalPhase();
		trace("TODO send data over network");
	}

	function stopSounds() {
		for (i in 0...5) {
			attempt[i].stopPlayActual();
		}
	}


	static function main() {
		new ListenRhythm();
	}
}

