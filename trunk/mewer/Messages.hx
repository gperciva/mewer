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
}


