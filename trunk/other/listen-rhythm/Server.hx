class Server {
	var save: haxe.io.Output;

	function new() {
//		save = neko.io.File.write("choices.txt", false);
		save = neko.io.File.append("choices.txt", false);
	}

	function record(data) {
		save.writeString(Std.string( data ));
		save.flush();
//		save.close();

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
