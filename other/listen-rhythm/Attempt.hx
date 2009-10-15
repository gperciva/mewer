class Attempt_1_1_mp3 extends flash.media.Sound {}
class Attempt_1_2_mp3 extends flash.media.Sound {}
class Attempt_1_3_mp3 extends flash.media.Sound {}
class Attempt_1_4_mp3 extends flash.media.Sound {}


class Attempt {
	var phaseNumber : Int;
	var realNumber : Int;
	var name : String;

	public function new(phaseNumberGet : Int, realNumberGet : Int) {
		phaseNumber = phaseNumberGet;
		realNumber = realNumberGet;
		name = "Attempt_" + Std.string(phaseNumber)
			+ "_"+Std.string(realNumber);
	}

	public function selected() {
		trace(realNumber);
	}

	public function imageName() {
		return name + "_png";
	}

	public function startPlay() {
		var soundFile = name + "_mp3";

		trace("trying to load sound");
		var sound : flash.media.Sound = cast Type.createInstance(
			Type.resolveClass(soundFile), []);
		trace(sound);

		trace(sound.length);
//		sound.play();
//		trace("trying to play");
	}

	public function stopPlay() {
		trace("stop playing " + name);
	}

}


