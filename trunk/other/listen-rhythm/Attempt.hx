class Attempt {
	var phaseNumber : Int;
	var realNumber : Int;

	public function new(phaseNumberGet : Int, realNumberGet : Int) {
		phaseNumber = phaseNumberGet;
		realNumber = realNumberGet;
	}

	public function selected() {
		trace(realNumber);
	}

	public function imageName() {
		return Std.string(phaseNumber) + "-" +
			Std.string(realNumber) + "-png";
	}

	public function startPlay() {

	}

	public function stopPlay() {

	}

}


