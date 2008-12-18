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

class Metronome {
	var bpm : Float;

	var timer : haxe.Timer;
	var lastTime : Int;
	var timerInterval : Int; // milliseconds
	var targetDelay : Int; // milliseconds

	var beatDisplay : Rectangle;

#if flash9
	var soundArray : Array<Float>;
	var sound : flash.media.Sound;
#end

	public function new() {
		lastTime = Math.floor(haxe.Timer.stamp() * 1000);
		timerInterval = 10;

#if flash9
		soundArray = getBeep();
		sound = new flash.media.Sound();
		sound.addEventListener("sampleData", copySine);
#end
		beatDisplay = new Rectangle({
			x: 0, y: 0, width: 480,
			height: 10, fill: "white"});
		Root.appendChild(beatDisplay);

		set(60);
	}

	public function reset() {
		// do nothing
	}

	public function set(bpmGet : Float) {
		bpm = bpmGet;
		targetDelay = Math.round(60000/bpm);
	}

	public function start() {
		timer = new haxe.Timer(timerInterval);
		timer.run = handleTimer;
	}

	public function stop() {
		timer.stop();
#if js
// workaround for bug
		timer = null;
#end
	}

	inline function handleTimer() {
		var currentTime:Int = Math.floor(haxe.Timer.stamp() * 1000);
		var delta:Int = currentTime - lastTime;
		var err:Int = delta-targetDelay;

		if ( err > -(timerInterval / 2)) {
//trace(err);
			lastTime = currentTime - err;
			if (err < 3*timerInterval)
				beat();
		}
	}

	inline function beat() {
		Root.removeChild(beatDisplay);
		beatDisplay = new Rectangle({
			x: 0, y: 0, width: 480,
			height: 10, fill: "red"});
		Root.appendChild(beatDisplay);
#if flash9
		sound.play();
#end
		haxe.Timer.delay(noBeat,100);
	}

	inline function noBeat() {
		Root.removeChild(beatDisplay);
		beatDisplay = new Rectangle({
			x: 0, y: 0, width: 480,
			height: 10, fill: "white"});
		Root.appendChild(beatDisplay);
	}

#if flash9
	function getBeep():Array<Float> {
		var array = new Array<Float>();
		for ( c in 0...1024 )
			array[c] = Math.sin((c/Math.PI/2))*0.25;
		return array;
	}

	inline function copySine(event) : Void {
		for ( c in 0...1024) {
			var sample = soundArray[c];
			event.data.writeFloat(sample);
			event.data.writeFloat(sample);
		}
	}
#end
}

