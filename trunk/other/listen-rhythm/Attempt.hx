class Attempt {
	var realNumber : Int;
	var orderNumber : Int;

	public function new(realNumberGet : Int, orderNumberGet: Int) {
		realNumber = realNumberGet;
		orderNumber = orderNumberGet;
	}

	public function selected() {
		trace(realNumber);
	}

}


