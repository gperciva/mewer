package ui;
import arctic.Arctic;
import arctic.ArcticView;
import arctic.ArcticBlock;

class UI {
	static inline var result_url : String = "http://markov.music.gla.ac.uk/cmt-wiki/GrahamPercival";

	var arcticView : ArcticView;
	var parent : ArcticMovieClip;

	public function new(parentMC : ArcticMovieClip) {
		arcticView = null;
		parent = parentMC;
	}

	public function networkError(url : String) {
		if (arcticView != null) { arcticView.destroy(); }

		var scene = Background(0xeeeeee, LineStack([
			ColumnStack([Filler,
				Arctic.makeText("Rhythmic Evaluation Survey",
					40), Filler]),
			Arctic.makeText(" ", 20),
			Arctic.makeText("Sorry, a network error has occurred while trying to access",
				20),
			Arctic.makeText(url, 10),
			Arctic.makeText(" ", 20),
			Arctic.makeText("Please try again in a few minutes.", 20)
		]));

		arcticView = new ArcticView(scene, parent);
		var root = arcticView.display(true);
	}


	public function showMain(beginFunc : Dynamic,
		setUserSkill : Dynamic)
	{
		if (arcticView != null) { arcticView.destroy(); }

		var mainLabel = Background(0xeeeeee, LineStack( [
			ColumnStack( [ Filler,
				Arctic.makeText("Rhythmic Evaluation Survey",
					40), Filler]),
			Filler,
			ColumnStack([
				Filler,
				Background(0x777777,
					Border(1,1, Background(0xffffcc,
				LineStack( [
				Arctic.makeText("1. Instructions", 30),
				Arctic.makeText("On each of the next 5 screens, please rank how", 18),
				Arctic.makeText("well each of 4 rhythms match the notated rhythm.  ", 18),
				Fixed(10,10),
				Arctic.makeText("Exercises are clapped with a metronome, which", 18),
				Arctic.makeText("has a one-bar (four beats) introduction.  ", 18),
				Fixed(10,10),
				Arctic.makeText("The correct rhythm is provided.", 18),
				])))),
				Filler,
			]),
			Filler,
			ColumnStack([
				Filler,
				Background(0x777777,
				Border(1,1, Background(0xccffff,LineStack([
				Arctic.makeText("2. Your musical skill ",30),
				Arctic.makeTextChoice(
					["Unskilled", "Student or Amateur",
					"Professional"], setUserSkill,
					0, 18).block,
				])))),
				Filler,
				Background(0x777777,
					Border(3,3, Background(0xaaeeaa,
					Arctic.makeSimpleButton(
						"3. Begin ranking",
						beginFunc, 30)))),
				Filler ]),
			Filler
		]));
		arcticView = new ArcticView( mainLabel, parent);
		var root = arcticView.display(true);
	}

	// the extra space is deliberate for spacing issues.
	function numToLetter(num : Int) : String {
		if (num == 1)
			return ' A';
		if (num == 2)
			return ' B';
		if (num == 3)
			return ' C';
		if (num == 4)
			return ' D';
		return '  ';
	}

	function drawAttempt(number : Int, data : Attempt) {
		var rightSide : Dynamic;
		var backgroundAttempt;
		if (data.isPerfect() == 1) {
			rightSide = LineStack([
				Filler,
				ColumnStack( [
					Filler,
					Arctic.makeText("(correct rhythm)", 18),
					Filler
				]),
				Filler
			]);
			backgroundAttempt = 0xeeeeaa;
		} else {
			var choices = Arctic.makeTextChoiceBlocks([
				"1    ", "2    ", "3    ",
				"4    ", "5    ", "6    ", "7"],
				data.setResult, 9, 18);
			var choicesBox = { block: ColumnStack(choices.blocks),
				selectFn: choices.selectFn};
			rightSide = LineStack( [
				Filler,
//				ColumnStack( [
//					Arctic.makeText("Very", 14), Filler,
//					Arctic.makeText("Very", 14),
//				]),
				ColumnStack( [
					Arctic.makeText("Bad", 18), Filler,
					Arctic.makeText("Good    ", 18),
				]),
				GradientBackground("linear",
					[0xbbbbee, 0xeeeeaa], 0, 0,
					choicesBox.block),
				Filler
			]);
			backgroundAttempt = 0xeeeeee;
		}
		// arctic 1.0.1 has problems with two fillers
		var center = 80;
		var colorStop = 0xCC0000;
		var colorPlay = 0x00CC00;
		// this is getting really ugly
		if (number == 0) {
			center += 37;
			//colorStop = 0xCC7777;
			//colorPlay = 0x77CC77;
		}

		var playControls = ColumnStack( [
					ConstrainWidth(center,center, Filler),
					Background(colorStop,
						Arctic.makeSimpleButton("Stop",
						data.stopPlay, 16)),
					Background(colorPlay,
						Arctic.makeSimpleButton("Play",
						data.startPlay, 16)),
					ConstrainWidth(center,center, Filler),
				 ]);

		var leftSide : Dynamic;
		if (number == 0) {
			leftSide = LineStack( [
				Picture(data.imageName(),323,50,1.0),
				playControls
			]);
		} else {
			leftSide = ColumnStack([
				LineStack ([
					Filler,
					Arctic.makeText(numToLetter(number), 36),
					Filler
				]),
				LineStack ([
					Filler,
					playControls
				])
			]);
		}


		return Background(0x999999, Border(1,1,
			Background(backgroundAttempt, ColumnStack ( [
				leftSide,
				rightSide
			])
		)));
	}

	public function showLevel(phase : Int, max_phase : Int,
		attempt : Array<Attempt>, advanceLevel : Dynamic)
	{
		if (arcticView != null) { arcticView.destroy(); }

		var drawed : Array<Dynamic> = new Array();
		for (i in 0...5) {
			drawed[i] = drawAttempt( i, attempt[i] );
		}

		var notation = ColumnStack( [
			LineStack([
				Filler,
				Picture(phase+"_notation_png",323,50,1.0),
				Filler
			]),
			Filler,
			LineStack([
				Filler,
				Arctic.makeText("Rank exercises A-D", 30),
				Filler
			]),
			Filler
		]);

		var status = Background(0xcccccc, ColumnStack([
			LineStack([Filler,
				Arctic.makeText("Screen "+
				phase+" of "+max_phase, 20),
				Filler
			]),
			Filler,
			LineStack([Filler,
			Background(0x444444,
				Border(3,3, Background(0xaaeeaa,
					Arctic.makeSimpleButton(
					"Next screen", advanceLevel, 18)))),
				Filler
			])
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

	public function showFinalPhase() {
		if (arcticView != null) { arcticView.destroy(); }

		var scene = Background(0xeeeeee, ColumnStack([
			Filler, LineStack( [
			Filler,
			Arctic.makeText("Thank you for completing the survey", 30),
			Arctic.makeText("  sending your answers over the network...", 20),
			Arctic.makeText(" ", 20),
			Filler,
			Arctic.makeText(" ", 20),
			Arctic.makeText(" ", 20),
			Arctic.makeText(" ", 20),
			Filler
			]),
			Filler]));

		arcticView = new ArcticView(scene, parent);
		var root = arcticView.display(true);
	}

	public function showThanks() {
		if (arcticView != null) { arcticView.destroy(); }

		var scene = Background(0xeeeeee, ColumnStack([
			Filler, LineStack( [
			Filler,
			Arctic.makeText("Thank you for completing the survey", 30),
			Arctic.makeText("  sending your answers over the network...", 20),
			Arctic.makeText("  ... finished sending data", 20),
			Filler,
			Arctic.makeText("If you would like to see the survey results, please view", 20),
			Arctic.makeText("<a href=\"" + result_url
				+ "\">" + result_url
				+ "</a>", 20, "#0000dd"),
			Arctic.makeText("in a few weeks.", 20),
			Filler
			]),
			Filler]));

		arcticView = new ArcticView(scene, parent);
		var root = arcticView.display(true);

	}

}
