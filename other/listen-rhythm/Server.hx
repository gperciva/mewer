class Server {
	var save: haxe.io.Output;

	function new() {
	}

	function record(results:List<Array<Int>>, secret:String) {
		if (secret == Config.secret) {
			var filename : String;
			var save_file : neko.io.FileOutput;
			filename = "choices-"+neko.Sys.time()+".txt";
			save = neko.io.File.write(filename, false);
			save.writeString(Std.string( results ) + '\n');
			save.close();
			return 0;
		}
		return 1;
	}

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());
		if (haxe.remoting.HttpConnection.handleRequest(ctx))
			return;
		trace("Configured");
	}
}
