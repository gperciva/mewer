class Server {
	function new() {
	}

	function ping(secret:String) {
		if (secret == Config.secret) {
			return 0;
		}
		return 1;
	}

	function record(userSkill : Int, results : List<Array<Int>>,
		secret:String)
	{
		if (secret == Config.secret) {
			var filename : String;
			var save_file : neko.io.FileOutput;
			filename = "choices-"+neko.Sys.time()+".txt";
			save_file = neko.io.File.write(filename, false);
			save_file.writeString(userSkill + '\t' +
				Std.string( results ) + '\n');
			save_file.close();
			return 0;
		}
		return 1;
	}

	static function main() {
		var ctx = new haxe.remoting.Context();
		ctx.addObject("Server", new Server());
		if (haxe.remoting.HttpConnection.handleRequest(ctx))
			return;
	}
}
