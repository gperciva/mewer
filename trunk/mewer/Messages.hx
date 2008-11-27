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
				fill:Paint.RGBColor(0.3,0.3,0.9)
		}));
		window.appendChild( new Text({
			text:"Fireworks and Balloons!", font_size: 20,
			fill: "black",
			x:80, y:20,
		}));
		window.appendChild( new Text({
			text:"Congratulations, you completed the final level!",
			font_size: 18,
			fill: "black",
			x:5, y:45,
		}));
		window.appendChild(UIgen.xinfButton(
			"Repeat level "+maxLevel, 100,75,125, clearPop));
		window.appendChild(UIgen.xinfButton(
			"Quit to main", 260,75,110, quit));
		return window;
	}

	static public function showTutorialWin(quit : Dynamic) : Group
	{
		var window = new Group();
		window.transform = new Translate(50,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 380,
                                height: 100,
				fill:Paint.RGBColor(0.3,0.3,0.9)
		}));
		window.appendChild( new Text({
			text:"Fireworks and Balloons!", font_size: 20,
			fill: "black",
			x:80, y:20,
		}));
		window.appendChild( new Text({
			text:"Congratulations, you completed the Tutorial!",
			font_size: 18,
			fill: "black",
			x:5, y:45,
		}));
		window.appendChild(UIgen.xinfButton(
			"Quit to main", 260,75,110, quit));
		return window;
	}

	static public function warnOnsets(expectedNum : Int, detectedNum
: Int, clearPop : Dynamic)
	{
		var window = new Group();
		window.transform = new Translate(110,50);

                window.appendChild( new Rectangle({
                                x: 0, y: 0, width: 260,
                                height: 100, fill:"white"
		}));
		window.appendChild( new Text({
			text:"How many notes?", font_size: 20,
			fill: "black",
			x:50, y:20,
		}));
		window.appendChild( new Text({
			text:"This exercise expects "+expectedNum+" notes,",
			font_size: 18,
			fill: "black",
			x:5, y:45,
		}));
		window.appendChild( new Text({
			text:"but MEWER detected "+detectedNum+" notes.",
			font_size: 18,
			fill: "black",
			x:5, y:65,
		}));
		window.appendChild(UIgen.xinfButton(
			"Oops!", 100,75,60, clearPop));
		return window;
	}



}


