
class ListenRhythm {
	static inline var MAX_PHASE = 4;

	var ui : ui.UI;
	var cnx : haxe.remoting.HttpAsyncConnection;
	var phase : Int;

	var userSkill : Int;

	var attempt : Array<Attempt>;
	var results : List<Array<Int>>;

	var loader : flash.net.URLLoader;

	public function new() {
		phase = 0;
		results = new List();
		attempt = null;
		userSkill = 0;

		ui = new ui.UI(flash.Lib.current);

		// network setup
		var url = Config.url + '?ping=1';
		loader = new flash.net.URLLoader();
		loader.addEventListener(flash.events.Event.COMPLETE, ask_ping);
		loader.load(new flash.net.URLRequest(url));
	}

	private function ask_ping(event:flash.events.Event) : Void {
		var response : String = loader.data;
		if (response == "pong\n") {
			ui.showMain(advanceLevel, setUserSkill);
		} else {
			ui.networkError(null);
		}
	}


	public function sendData() {
//		cnx.Server.record.call( [userSkill, results, Config.secret],
//			networkAnswer);
		cnx.call( [userSkill, results, Config.secret],
			networkAnswer);
	}

	public function networkAnswer(error: Int) {
		if (error == 0) {
			ui.showThanks();
		}
	}

	function setUserSkill(userSkillGet: Int, textGet: String) {
		userSkill = userSkillGet;
		// we don't need the text
	}

	function advanceLevel() {
		phase++;
		if (attempt != null) {
			var resultsPrevious = new Array<Int>();
			resultsPrevious[0] = 0;
			resultsPrevious[1] = 0;
			for (i in 1...5) {
				var res = attempt[i].getResult();
				var pos = attempt[i].getRealNumber();
				resultsPrevious[pos] = res;
			}
			results.push( resultsPrevious );
		}
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
	}

	function finalPhase() {
		ui.showFinalPhase();
		sendData();
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

