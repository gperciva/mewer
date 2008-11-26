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

#if flash9
	var ctx : haxe.remoting.Context;
	var jsconnect : haxe.remoting.ExternalConnection;
#end
	var bpm : Float;

	public function new() {
#if flash9
		ctx = new haxe.remoting.Context();
		ctx.addObject("Metronome",Metronome);
		jsconnect = haxe.remoting.ExternalConnection.jsConnect("default",ctx);
#end
	}

	public function delete() {
#if flash9
		jsconnect.close();
	trace(jsconnect);
#end
	}

	public function set(bpmGet : Float) {
		bpm = bpmGet;
	}

	public function start() {
#if flash9
		jsconnect.ExtraMetro.start.call([bpm]);
#elseif js
        	var writeDiv = js.Lib.document.getElementById("metro");
        	writeDiv.innerHTML = '<img src="metro/metro-' + bpm + '.gif">';
#end
	}

	public function stop() {
#if flash9
		jsconnect.ExtraMetro.stop.call([]);
#elseif js
        	var writeDiv = js.Lib.document.getElementById("metro");
        	writeDiv.innerHTML = '<img src="metro/nobeat.gif">';
#end
	}

}

