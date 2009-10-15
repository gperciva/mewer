class Attempt_1_1_mp3 extends flash.media.Sound {}
class Attempt_1_2_mp3 extends flash.media.Sound {}
class Attempt_1_3_mp3 extends flash.media.Sound {}
class Attempt_1_4_mp3 extends flash.media.Sound {}


class Attempt {
	var phaseNumber : Int;
	var realNumber : Int;
	var name : String;

	var callbackStopSounds : Dynamic;
	var sound : flash.media.Sound;

	public function new(phaseNumberGet : Int, realNumberGet : Int,
		callbackStopSoundsGet : Dynamic) {
		phaseNumber = phaseNumberGet;
		realNumber = realNumberGet;
		callbackStopSounds = callbackStopSoundsGet;

		name = "Attempt_" + Std.string(phaseNumber)
			+ "_"+Std.string(realNumber);
		sound = Type.createInstance(Type.resolveClass(name+"_mp3"), []);
	}

	public function selected() {
		trace(realNumber);
	}

	public function imageName() {
		return name + "_png";
	}

	public function startPlay() {
		callbackStopSounds();
		trace(sound.length);
		sound.play();
	}

	public function stopPlayActual() {
		trace("stop playing " + name);
		sound.stop();
	}

	public function stopPlay() {
		callbackStopSounds();
	}

}


