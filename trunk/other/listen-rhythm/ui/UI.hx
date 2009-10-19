package ui;
import arctic.Arctic;
import arctic.ArcticView;
import arctic.ArcticBlock;

class UI {
	static inline var MAX_PHASE = 2;

	var arcticView : ArcticView;
	var parent : ArcticMovieClip;

	public function new(parentMC : ArcticMovieClip) {
		arcticView = null;
		parent = parentMC;
	}

	public function showMain(beginFunc : Dynamic) {
		if (arcticView != null) { arcticView.destroy(); }

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
		var rightSide : Dynamic;
		if (data.isPerfect() == 1) {
			rightSide = LineStack([
				Filler,
				ColumnStack( [
					Filler,
					Arctic.makeText("(perfect rhythm)", 18),
					Filler
				]),
				Filler
			]);
		} else {
			var choices = Arctic.makeTextChoiceBlocks([
				"1    ", "2    ", "3    ",
				"4    ", "5    ", "6    ", "7"],
				null, 3, 18);
			var choicesBox = { block: ColumnStack(choices.blocks),
				selectFn: choices.selectFn};
			rightSide = LineStack( [
				Filler,
				ColumnStack( [
					Arctic.makeText("Bad", 18), Filler,
					Arctic.makeText("Ok", 18), Filler,
					Arctic.makeText("Good", 18),
				]),
				GradientBackground("linear",
					[0xaaaaff, 0xffff77], 0, 0,
					choicesBox.block),
				Filler
			]);
		}
		// arctic 1.0.1 has problems with two fillers
		var center = 100;

		return Background(0x999999, Border(1,1,
			Background(0xeeeeee, ColumnStack ( [
			LineStack( [
				Picture(data.imageName(),300,40,1.0),
				ColumnStack( [
					ConstrainWidth(center,center, Filler),
					Background(0xCC0000,
						Arctic.makeSimpleButton("Stop",
						data.stopPlay, 16)),
					Background(0x00CC00,
						Arctic.makeSimpleButton("Play",
						data.startPlay, 16)),
					ConstrainWidth(center,center, Filler),
				 ]),
			]),
			rightSide
		]))));
	}

	public function showLevel(phase : Int, attempt : Array<Attempt>,
		advanceLevel : Dynamic)
	{
		trace("UI showLevel, phase: "+phase);

		if (arcticView != null) {
			trace("clear screen");
			arcticView.destroy();
			trace("********** screen blank now");
		}

		var drawed : Array<Dynamic> = new Array();
		for (i in 0...5) {
			drawed[i] = drawAttempt( attempt[i] );
		}

		var notation = ColumnStack( [
			Picture(phase+"_notation_png",300,40,1.0),
			Filler,
			Arctic.makeText("Rank these exercise attempts", 20),
			Filler
		]);

		var status = Background(0xcccccc, ColumnStack([
			LineStack([Filler,
				Arctic.makeText("Phase "+
				phase+" of "+MAX_PHASE, 20),
				Filler
			]),
			Filler,
			Background(0x444444,
				Border(3,3, Background(0xaaeeaa,
					Arctic.makeSimpleButton(
					"Next phase", advanceLevel, 18))))
		]));
		var scene = Background(0xeeeeee, LineStack( [
			notation,
			drawed[0],
			drawed[1],
			drawed[2],
			drawed[3],
			drawed[4],
			status
			]));

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
