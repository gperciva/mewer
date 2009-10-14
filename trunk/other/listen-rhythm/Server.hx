class Server {
	function new() {

	}

	function record(data:Int) {
		neko.Lib.print(data);
		trace("** this is my trace **");
		trace(data);
	}

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());
		if (haxe.remoting.HttpConnection.handleRequest(ctx))
			return;
		trace("Configured");
	}
}
