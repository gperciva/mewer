/*
  MEWER - MEWsician's Exercises for Rhythms
  Copyright (C) 2008  Graham Percival <graham@percival-music.ca>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

package mewer;

import Xinf;

enum Result {
  Fail;
  Pass;
  Advance;
  Win;
}

enum ExerciseState {
  Menu;
  Prep;
  Running;
  Stop;
}


class UI {
	// persistent objects
	var exerPrep : Dynamic;
	var exerStart : Dynamic;
	var exerStop : Dynamic;
	var quit : Dynamic;
#if flash9
	var drawMain : Dynamic;
#end

	var statusArea : Group;
	var statusText : Text;
	var alignArea: Group;

	// program options
	var useMic : Bool;
	var exerState : ExerciseState;

	// per-game
	var detected : List<Float>;
	var popWindow : Group;


	public function new(exerPrepGet : Dynamic,
			exerStartGet : Dynamic, exerStopGet :
			Dynamic, quitGet : Dynamic) {
		exerPrep = exerPrepGet;
		exerStart = exerStartGet;
		exerStop = exerStopGet;
		quit = quitGet;
		setArea();

		useMic = false;
		exerState = Menu;

		Root.addEventListener(KeyboardEvent.KEY_DOWN, handleKey);
	}

	function setArea() {
		statusArea = new Group();
		statusArea.transform = new Translate(0,295);

		statusText = new Text({
                        x:5, y:19, fill:"black",
                        font_size:18
                        });
		statusArea.appendChild(statusText);
		Root.appendChild(statusArea);

		alignArea = new Group();
		alignArea.transform = new Translate(0,270);
		alignArea.display = xinf.ony.type.Display.None;
		alignArea.appendChild(UIgen.xinfButtonSmall(
			"Align to first", 10,10,60, setAlignFirst));
		alignArea.appendChild(UIgen.xinfButtonSmall(
			"Align to best", 200,10,64, setAlignBest));
		Root.appendChild(alignArea);
	}

	public function reset() {
		clearPop(null);
		statusArea.display = xinf.ony.type.Display.None;
		alignArea.display = xinf.ony.type.Display.None;
		exerState = Menu;
#if flash9
		if (useMic) {
			mic.removeEventListener(
				flash.events.ActivityEvent.ACTIVITY,
				clap);
		}
#end
	}

	public function handleKey(event:KeyboardEvent) {
		//trace(haxe.Timer.stamp()+"  Event: "+event.code);

		// do nothing if in menu
		if (exerState == Menu)
			return;

		// ESC
		if (event.code == 27) {
			promptMain();
		}

		// ENTER
		if (event.code == 13) {
			if (popWindow != null) {
				clearPop(null);
			} else {
				switch (exerState) {
				case Prep: exerRecord(Running);
				case Running: exerRecord(Stop);
				case Stop: exerRecord(Prep);
				case Menu: return;
				}
			}
		} else {
			if (exerState == Running)
				detected.add( haxe.Timer.stamp() );
		}
	}

	public function promptMain() {
		if (popWindow != null)
			clearPop(null);
		popWindow = new Group();
		popWindow.transform = new Translate(140,50);

                popWindow.appendChild( new Rectangle({
                        x: 0, y: 0, width: 200, height: 60,
			fill:Paint.RGBColor(0.3,0.3,0.9)
		}));
		popWindow.appendChild( new Text({
			text:"Return to menu?", font_size: 20,
			fill: "black",
			x:30, y:20,
		}));
		popWindow.appendChild(UIgen.xinfButton(
			"Cancel", 20,30,70, clearPop));
		popWindow.appendChild(UIgen.xinfButton(
			"Yes, quit", 110,30,80, quit));
		Root.appendChild(popWindow);
	}

	public function getDetected() : List<Float> {
		return detected;
	}

	function setAlignFirst(event:MouseEvent) {
		exerStop(false);
	}

	function setAlignBest(event:MouseEvent) {
		exerStop(true);
	}

	public function exerOver() {
		alignArea.display = xinf.ony.type.Display.Inline;
#if flash9
		flash.Lib.current.stage.focus = flash.Lib.current;
#end
	}

#if flash9
	public function chooseInput(drawMainGet : Dynamic) {
		drawMain = drawMainGet;

		popWindow = new Group();
		popWindow.transform = new Translate(50,50);
		Root.appendChild(popWindow);

		popWindow.appendChild( new Text({
			text:"Select input source:", font_size: 20,
			x:0, y:20,
		}));

		popWindow.appendChild(UIgen.xinfButton(
			"Keyboard (tapping)", 10,30,190, selectKey ));
		popWindow.appendChild(UIgen.xinfButton(
			"Microphone (clapping)", 10,60,190, selectMic ));
	}

	function selectKey(event:MouseEvent) {
		useMic = false;
		Root.removeChild(popWindow);
		drawMain();
	}
#end

	public function prep() {
		detected = new List();
		statusArea.display = xinf.ony.type.Display.Inline;
		alignArea.display = xinf.ony.type.Display.None;
		exerState = Prep;
		statusText.text = "Press ENTER to begin exercise.";
		if (popWindow != null)
			clearPop(null);
#if flash9
		flash.Lib.current.stage.focus = flash.Lib.current;
#end
	}

	public function start() {
#if flash9
		if (useMic) {
			mic.addEventListener(
				flash.events.ActivityEvent.ACTIVITY,
				clap);
		}
#end
		statusText.text = "Perform exercise and press ENTER when finished.";
	}

	function clearPop(event : MouseEvent) {
		Root.removeChild(popWindow);
		popWindow = null;
#if flash9
                flash.Lib.current.stage.focus = flash.Lib.current;
#end
	}

	public function warnOnsets(expectedNum : Int, detectedNum : Int)
	{
		popWindow = Messages.warnOnsets(expectedNum, detectedNum, clearPop);
		Root.appendChild(popWindow);
	}

	public function showWin(maxLevel : Int)
	{
		popWindow = Messages.showWin(maxLevel, clearPop, quit);
		Root.appendChild(popWindow);
	}

	public function showTutorialWin()
	{
		popWindow = Messages.showTutorialWin(quit);
		Root.appendChild(popWindow);
	}

	public function showGrade(result:Result, grade:Float,
		level : Int, passed : Int, passNum : Int) {

		switch(result) {
			case Win:
				statusText.text = "You win! Score: " + grade + "%  (press ENTER)";
			case Advance:
				statusText.text = "Advance to level "+level+"!  Score: " + grade + "%  (press ENTER)";
			case Pass:
				statusText.text = "Passed "+passed+"/"+passNum+".  Score: " + grade + "%  (press ENTER)";
			case Fail:
				statusText.text = "Fail.  Score: " + grade + "%   (press ENTER)";
		}
	}

	function exerRecord(go:ExerciseState) {
		exerState = go;
		if (exerState == Prep) {
			exerPrep();
		}
		if (exerState == Running) {
			exerStart();
		}
		if (exerState == Stop) {
			exerStop(true);
		}
	}

	function clap(event) {
		if (event.activating == true) {
			detected.add( haxe.Timer.stamp() );
		}
	}




// *************** microphone stuff
#if flash9
	var mic : flash.media.Microphone;
	var silencePrompt : flash.text.TextField;

	function selectMic(event:Dynamic) {
		Root.removeChild(popWindow);

		mic = flash.media.Microphone.getMicrophone();
		if (mic != null) {
			mic.setUseEchoSuppression(true);
			mic.setLoopBack(true);
			mic.setSilenceLevel(1, 50);
			var trans = new flash.media.SoundTransform(0);
			mic.soundTransform = trans;
			mic.addEventListener(
				flash.events.StatusEvent.STATUS,onMicStatus);
		}
	}


	function onMicStatus(event:flash.events.StatusEvent) {
		mic.removeEventListener(
			flash.events.StatusEvent.STATUS,onMicStatus);
    		if (event.code == "Microphone.Unmuted") {
			var silenceWindow = new flash.display.Sprite();
			silenceWindow.name = "silenceWindow";
			flash.Lib.current.addChild(silenceWindow);
			silenceWindow.x = 50;
			silenceWindow.y = 50;
			silencePrompt = new flash.text.TextField();
       		 	silencePrompt.defaultTextFormat =
				new flash.text.TextFormat(22);
			silencePrompt.text = "CALIBRATING SILENCE: 1";
			silencePrompt.autoSize =
				flash.text.TextFieldAutoSize.LEFT;
			silenceWindow.addChild(silencePrompt);

			mic.addEventListener(
				flash.events.ActivityEvent.ACTIVITY, silence);
			haxe.Timer.delay(finishedSilence, 2000);
		}
		else if (event.code == "Microphone.Muted") {
			trace("Microphone access was denied.");
		}
	}

	private function silence(event: Dynamic) {
		//trace(mic.activityLevel);
		if (event.activating == true) {
			var activity : Int =
				Std.int(mic.activityLevel);
			mic.setSilenceLevel( (activity+1),100);
			silencePrompt.text = "CALIBRATING SILENCE: " +
				(activity+1);
		}
	}

	function finishedSilence() {
		mic.removeEventListener(
			flash.events.ActivityEvent.ACTIVITY, silence);
		var silenceWindow = 
			flash.Lib.current.getChildByName("silenceWindow");
		flash.Lib.current.removeChild(silenceWindow);
		useMic = true;
		drawMain();
	}
#end


}


