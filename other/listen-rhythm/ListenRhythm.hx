
class ListenRhythm {
	static inline var MAX_PHASE = 4;

	var ui : ui.UI;
	var cnx : haxe.remoting.HttpAsyncConnection;
	var phase : Int;

	var userSkill : Int;

	var attempt : Array<Attempt>;
	var results : List<Array<Int>>;

	public function new() {
		phase = 0;
		results = new List();
		attempt = null;
		userSkill = 0;

		ui = new ui.UI(flash.Lib.current);
		ui.showMain(advanceLevel, setUserSkill);

		// network setup
		cnx = haxe.remoting.HttpAsyncConnection.urlConnect(Config.url);
		cnx.setErrorHandler(ui.networkError);
		cnx.Server.ping.call([Config.secret]);
	}

	public function sendData() {
		cnx.Server.record.call( [userSkill, results, Config.secret],
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

