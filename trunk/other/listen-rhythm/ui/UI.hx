package ui;
import arctic.Arctic;
import arctic.ArcticView;
import arctic.ArcticBlock;

class UI {
	var arcticView: ArcticView;

	public function new() {
		var helloWorld = Arctic.makeSimpleButton("Hello world", null, 50);
		//var ratingButtons = Arctic.makeTextChoice([ "1", "2", "3"], null);

		arcticView = new ArcticView(helloWorld, flash.Lib.current);
		var root = arcticView.display(true);
	}


	static public function label(
		text: String, x: Int, y: Int
	) {
		var label = new flash.text.TextField();
		label.text = text;
		label.x = x;
		label.y = y;
		return label;
	}

	static public function clearScreen() {
		for (i in 0...flash.Lib.current.numChildren) {
			flash.Lib.current.removeChildAt(0);
		}
	}

	static public function button(
		text: String, x: Int, y: Int, ?pressed: Dynamic
	) {
var myRectangle : flash.display.Sprite= new flash.display.Sprite();
myRectangle.graphics.beginFill ( 0x990000 );  // the color of the rectangle
myRectangle.graphics.lineStyle ( 1, 0x000000, 1, false, flash.display.LineScaleMode.NONE ); // the border style
// we add the rectangle at the high-left corner (coordinate 0,0 )of the screen, with a width and a length of 10.
myRectangle.graphics.drawRect ( 0, 0, 50, 50);

myRectangle.addEventListener(flash.events.MouseEvent.MOUSE_UP, pressed);
return myRectangle;


	}

}
