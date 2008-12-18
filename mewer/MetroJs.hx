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

class Metronome {

	var bpm : Float;

	public function new() {
		set(60);
	}

	public function reset() {
		stop();
	}

	public function set(bpmGet : Float) {
		bpm = bpmGet;
	}

	public function start() {
#if js
        	var writeDiv = js.Lib.document.getElementById("metro");
        	writeDiv.innerHTML = '<img src="metro/metro-' + bpm + '.gif">';
#end
	}

	public function stop() {
#if js
        	var writeDiv = js.Lib.document.getElementById("metro");
        	writeDiv.innerHTML = '<img src="metro/nobeat.gif">';
#end
	}

}

