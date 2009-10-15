class Foo extends flash.media.Sound {}

class Attempt {
	var phaseNumber : Int;
	var realNumber : Int;
	var name : String;

	public function new(phaseNumberGet : Int, realNumberGet : Int) {
		phaseNumber = phaseNumberGet;
		realNumber = realNumberGet;
		name = Std.string(phaseNumber)+"-"+Std.string(realNumber);
	}

	public function selected() {
		trace(realNumber);
	}

	public function imageName() {
		return name + "-png";
	}

	public function startPlay() {
		var soundFile = name + "-mp3";
		trace("trying to load sound");
		var sound : flash.media.Sound = new Foo();
/*
		var sound : flash.media.Sound = Type.createInstance(
			Type.resolveClass("resources.classes.1-1-mp3"), []);
*/
		trace(sound.length);
		sound.play();
		trace("trying to play");
	}

	public function stopPlay() {
		trace("stop playing " + name);
	}

}


