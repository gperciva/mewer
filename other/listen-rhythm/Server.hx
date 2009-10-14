class Server {
	function new() {

	}

	function record(data) {
//		neko.Lib.print("got data");
	//	neko.Lib.print(data);
//		trace("** this is my trace **");
//		trace(data);
//		return x+y;

		var save : haxe.io.Output = neko.io.File.write("foo", false);
		save.writeString("1");
		save.close();

		return 0;
	}

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());
		if (haxe.remoting.HttpConnection.handleRequest(ctx))
			return;
		trace("Configured");
	}
}
