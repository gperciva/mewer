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

class Messages {
	inline static var popBackground = Paint.RGBColor(0,0,0.7);
	inline static var popText = Paint.RGBColor(1,1,1);

	static public function getTips(drawMain : Dynamic) : Group {
		var window = new Group();

		window.appendChild( new Text({
			x:10, y:30, width:450, fill:"black",
			font_size:16, text:
		"1. You can use any key other than ESC and ENTER to indicate
	notes.  If your space bar is unreliable, try using other keys!"
		}));
		window.appendChild( new Text({
			x:10, y:70, width:450, fill:"black",
			font_size:16, text:
		"2. Don't REACT to the metronome -- if you wait for a
	flash, your clap or tap will be late.  Instead, try to
	INTERNALIZE the tempo so that you know when the next
	beat will occur.  Try tapping your foot (quietly!) or
	nodding your head with the metronome for a few bars
	before you begin!"
		}));

                window.appendChild(UIgen.xinfButton(
                        "Return to main", 300,250,130,
			drawMain));
		return window;
	}


	static public function showWin(maxLevel : Int,
		clearPop : Dynamic, quit : Dynamic) : Group
	{
		var window = new Group();
		window.transform = new Translate(50,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 380,
                                height: 100,
				fill:popBackground
		}));
		window.appendChild( new Text({
			text:"Fireworks and Balloons!", font_size: 20,
			fill: popText,
			x:80, y:20,
		}));
		window.appendChild( new Text({
			text:"Congratulations, you completed the final level!",
			font_size: 18,
			fill: popText,
			x:5, y:45,
		}));
		window.appendChild(UIgen.xinfButton(
			"Repeat level "+maxLevel, 100,60,125, clearPop));
		window.appendChild(UIgen.xinfButton(
			"Quit to main", 260,60,110, quit));
		return window;
	}

	static public function showTutorialWin(clearPop : Dynamic,
			quit : Dynamic) : Group
	{
		var window = new Group();
		window.transform = new Translate(50,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 380,
                                height: 100,
				fill:popBackground
		}));
		window.appendChild( new Text({
			text:"Fireworks and Balloons!", font_size: 20,
			fill: popText,
			x:80, y:20,
		}));
		window.appendChild( new Text({
			text:"Congratulations, you completed the Tutorial!",
			font_size: 18,
			fill: popText,
			x:5, y:45,
		}));
		window.appendChild(UIgen.xinfButton(
			"Repeat tutorial", 100,65,125, clearPop));
		window.appendChild(UIgen.xinfButton(
			"Quit to main", 260,65,110, quit));
		return window;
	}

	static public function warnOnsets(expectedNum : Int, detectedNum
: Int, clearPop : Dynamic)
	{
		var window = new Group();
		window.transform = new Translate(110,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 260,
                                height: 100, fill:popBackground
		}));
		window.appendChild( new Text({
			text:"How many notes?", font_size: 20,
			fill: popText,
			x:50, y:20,
		}));
		window.appendChild( new Text({
			text:"This exercise expects "+expectedNum+" notes,",
			font_size: 18,
			fill: popText,
			x:5, y:45,
		}));
		window.appendChild( new Text({
			text:"but MEWER detected "+detectedNum+" notes.",
			font_size: 18,
			fill: popText,
			x:5, y:65,
		}));
		window.appendChild(UIgen.xinfButton(
			"Oops!", 100,75,60, clearPop));
		return window;
	}


	static public function showTutorialHelp(closePop : Dynamic) : Group
	{
		var window = new Group();
		window.transform = new Translate(50,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 400,
                                height: 230,
				fill:popBackground
		}));
		window.appendChild( new Text({
			text:"MEWER introduction", font_size: 20,
			fill: popText, x:100, y:20,
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:45,
			text:"1. Press ENTER to start/stop the exercise.",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:65,
			text:"2. Watch the metronome at the top of the screen.",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:85,
			text:"3. Clap or tap the rhythm in the exercise."
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:105,
			text:"	  (there are only 8 notes!)",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:125,
			text:"4. Stop the exercise, and view the results:",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:145,
			text:"	  BLACK lines show the correct times,",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:165,
			text:"	  RED lines show what you did!",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:185,
			text:"5. Attempt new exercise, or press ESC to ",
		}));
		window.appendChild( new Text({
			font_size: 18, fill: popText, x:5, y:205,
			text:"	  return to the main menu.",
		}));

		window.appendChild(UIgen.xinfButton(
			"Close", 280,200,80, closePop));
		return window;
	}

	static public function showPromptMain(closePop : Dynamic,
		quit : Dynamic) : Group
	{
		var window = new Group();
		window.transform = new Translate(140,50);

                window.appendChild( new Rectangle({
                        x: 0, y: 0, width: 200, height: 60,
			fill:popBackground
		}));
		window.appendChild( new Text({
			text:"Return to menu?", font_size: 20,
			fill: popText, x:30, y:20,
		}));
		window.appendChild(UIgen.xinfButton(
			"Cancel", 20,30,70, closePop));
		window.appendChild(UIgen.xinfButton(
			"Yes, quit", 110,30,80, quit));

		return window;
	}

}


