
class ListenRhythm {
	static inline var MAX_PHASE = 5;

	var ui : ui.UI;
	var cnx : haxe.remoting.HttpAsyncConnection;
	var phase : Int;

	var userSkill : Int;

	var attempt : Array<Attempt>;
	var results : List<String>;

	var loader : flash.net.URLLoader;
	var url : String;

	var lastNewScreenTime : Float;

	public function new() {
		phase = 0;
		results = new List();
		attempt = null;
		userSkill = 0;
		url = '';
		lastNewScreenTime = 0;

		ui = new ui.UI(flash.Lib.current);

		// network setup
		loader = new flash.net.URLLoader();
		loader.addEventListener(flash.events.Event.COMPLETE, ask_ping);
		url = getURL('?ping=1');
		loader.load(new flash.net.URLRequest(url));
	}

	function getURL(command : String) : String {
		url = Config.url;
#if A
		url += 'A';
#end
#if B
		url += 'B';
#end
#if C
		url += 'C';
#end
#if D
		url += 'D';
#end
#if E
		url += 'E';
#end
#if F
		url += 'F';
#end
#if G
		url += 'G';
#end
		url += Config.url_ext;
		url += command;
		return url;
	}

	function ask_ping(event:flash.events.Event) {
		var response : String = loader.data;
		if (response == "pong\n") {
			ui.showMain(advanceLevel, setUserSkill);
		} else {
			ui.networkError(url);
		}
	}


	function sendData() {
		loader = new flash.net.URLLoader();
		loader.addEventListener(flash.events.Event.COMPLETE, ask_data);
		var command = '?action=record';
		command += '&skill=' + userSkill;
		command += '&1=' + results.pop();
		command += '&2=' + results.pop();
		command += '&3=' + results.pop();
		command += '&4=' + results.pop();
		command += '&5=' + results.pop();
		url = getURL(command);

		loader.load(new flash.net.URLRequest(url));
	}

	function ask_data(event:flash.events.Event) {
		var response : String = loader.data;
		if (response == "written\n") {
			ui.showThanks();
		} else {
			ui.networkError(url);
		}
	}

	function setUserSkill(userSkillGet: Int, textGet: String) {
		userSkill = userSkillGet;
		// we don't need the text
	}

	function advanceLevel() {
		var nowTime = Date.now().getTime();
		// wait at least 1 second
		if (nowTime < (lastNewScreenTime + 1000))
			return;
		lastNewScreenTime = nowTime;

		phase++;
		if (attempt != null) {
			// un-randomize Attempts
			var resultsPrevious = new Array<Int>();
			resultsPrevious[0] = 0;
			resultsPrevious[1] = 0;
			for (i in 1...5) {
				var res = attempt[i].getResult();
				var pos = attempt[i].getRealNumber();
				resultsPrevious[pos] = res;
			}

			// convert to string
			var store : String = '';
			for (i in 1...5) {
				store += resultsPrevious[i];
			}
			results.add( store );
		}
		if (phase > MAX_PHASE) {
			finalPhase();
			return;
		}


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

		attempt[0] = new Attempt(phase, 0, stopSounds);
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

