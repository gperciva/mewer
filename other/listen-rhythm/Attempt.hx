class Attempt_1_1_mp3 extends flash.media.Sound {}
class Attempt_1_2_mp3 extends flash.media.Sound {}
class Attempt_1_3_mp3 extends flash.media.Sound {}
class Attempt_1_4_mp3 extends flash.media.Sound {}
class Attempt_1_5_mp3 extends flash.media.Sound {}


class Attempt {
	var phaseNumber : Int;
	var realNumber : Int;
	var name : String;

	var callbackStopSounds : Dynamic;
	var sound : flash.media.Sound;
	var soundChannel : flash.media.SoundChannel;

	var result : Int;

	public function new(phaseNumberGet : Int, realNumberGet : Int,
		callbackStopSoundsGet : Dynamic) {
		phaseNumber = phaseNumberGet;
		realNumber = realNumberGet;
		callbackStopSounds = callbackStopSoundsGet;

		name = "Attempt_" + Std.string(phaseNumber)
			+ "_"+Std.string(realNumber);
		sound = Type.createInstance(Type.resolveClass(name+"_mp3"), []);
		soundChannel = null;
	}

	public function isPerfect() {
		if (realNumber == 1)
			return 1;
		return 0;
	}

	public function selected() {
		trace(realNumber);
	}

	public function imageName() {
		return name + "_png";
	}

	public function startPlay() {
		callbackStopSounds();
		soundChannel = sound.play(0.0);
	}

	public function stopPlayActual() {
		if (soundChannel != null) {
			soundChannel.stop();
			soundChannel = null;
		}
	}

	public function stopPlay() {
		callbackStopSounds();
	}

	public function setResult(resultGet: Int, textGet: String) {
		result = resultGet + 1;
		// we don't need the text
	}

	public function getResult() {
		return result;
	}
}


