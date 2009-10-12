
class ListenRhythm {

	static function main() {
		trace("foo");

		var s:flash.display.MovieClip = flash.Lib.attach("foo-1-png");
		//var foo = flash.Lib.current.attach("foo-1-png");
		//foo._x = 40;
		//foo._x = 40;
		flash.Lib.current.addChild(s);

/*
        var mc:flash.display.MovieClip = flash.Lib.current;
        mc.graphics.beginFill(0xFF0000);
        mc.graphics.moveTo(50,50);
        mc.graphics.lineTo(100,50);
        mc.graphics.lineTo(100,100);
        mc.graphics.lineTo(50,100);
        mc.graphics.endFill();
*/

	}

}

