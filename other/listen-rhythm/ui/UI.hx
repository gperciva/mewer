package ui;
import arctic.Arctic;
import arctic.ArcticView;
import arctic.ArcticBlock;

class UI {
	var arcticView : ArcticView;
	var parent : ArcticMovieClip;

	public function new(parentMC : ArcticMovieClip) {
		arcticView = null;
		parent = parentMC;
	}

	public function showMain(beginFunc : Dynamic) {
		if (arcticView != null) { arcticView.destroy(); }

//		var beginFunc = attempts[1].selected;
/*
Filler,
Arctic.makeTextChoice([ "Excellent", "Good", "Ok", "Bad", "Terrible"],
	null, 2, 20).block,
				]),
			Filler
*/

		var mainLabel = LineStack( [
			ColumnStack( [ Filler,
				Arctic.makeText("Rhythmic Evaluation",50),
				Filler]),
			Filler,
			ColumnStack( [ Filler,
				Arctic.makeSimpleButton("Begin grading",
					beginFunc, 40), Filler]),
			Filler,]);
		arcticView = new ArcticView( mainLabel, parent);
		var root = arcticView.display(true);
	}


	function drawAttempt(data : Attempt) {
		return 
			Picture(data.imageName(),800,100,2.0);
	}

	public function showLevel(attempt : Array<Attempt>) {
		if (arcticView != null) { arcticView.destroy(); }

		var drawed : Array<Dynamic> = new Array();
		for (i in 0...4) {
			drawed[i] = drawAttempt( attempt[i] );
		}
		var scene = LineStack( [
			drawed[0], Filler,
			drawed[1], Filler,
			drawed[2], Filler,
			drawed[3]
			]);

		arcticView = new ArcticView(scene, parent);
		var root = arcticView.display(true);
	}


/*
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
*/

}
