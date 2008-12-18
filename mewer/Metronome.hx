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
#if metroflash
import Xinf;
#end

class Metronome {
	var bpm : Float;

#if metroflash
	var timer : haxe.Timer;
	var lastTime : Int;
	var timerInterval : Int; // milliseconds
	var targetDelay : Int; // milliseconds

	var beatDisplay : Rectangle;
	var soundArray : Array<Float>;
	var sound : flash.media.Sound;
#end
#if metrogif
        var ctx : haxe.remoting.Context;
        var jsconnect : haxe.remoting.ExternalConnection;
#end

	public function new() {
#if metroflash
		lastTime = Math.floor(haxe.Timer.stamp() * 1000);
		timerInterval = 10;

		soundArray = getBeep();
		sound = new flash.media.Sound();
		sound.addEventListener("sampleData", copySine);

		beatDisplay = new Rectangle({
			x: 0, y: 0, width: 480,
			height: 10, fill: "white"});
		Root.appendChild(beatDisplay);
#end
#if metrogif
                ctx = new haxe.remoting.Context();
                ctx.addObject("Metronome",Metronome);
                jsconnect = haxe.remoting.ExternalConnection.jsConnect("default",ctx);
#end

		set(60);
	}

	public function reset() {
		stop();
	}

	public function set(bpmGet : Float) {
		bpm = bpmGet;
#if metroflash
		targetDelay = Math.round(60000/bpm);
#end
	}

	public function start() {
#if metroflash
		timer = new haxe.Timer(timerInterval);
		timer.run = handleTimer;
#elseif js
		var writeDiv = js.Lib.document.getElementById("metro");
		writeDiv.innerHTML = '<img src="metro/metro-' + bpm + '.gif">';
#end
#if metrogif
                jsconnect.ExtraMetro.start.call([bpm]);
#end
	}

	public function stop() {
#if metroflash
		timer.stop();
#elseif js
        	var writeDiv = js.Lib.document.getElementById("metro");
        	writeDiv.innerHTML = '<img src="metro/nobeat.gif">';
#end
#if metrogif
                jsconnect.ExtraMetro.stop.call([]);
#end
	}



#if metroflash
	inline function handleTimer() {
		var currentTime:Int = Math.floor(haxe.Timer.stamp() * 1000);
		var delta:Int = currentTime - lastTime;
		var err:Int = delta-targetDelay;

		if ( err > -(timerInterval / 2)) {
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

		sound.play();

		haxe.Timer.delay(noBeat,100);
	}

	inline function noBeat() {
		Root.removeChild(beatDisplay);
		beatDisplay = new Rectangle({
			x: 0, y: 0, width: 480,
			height: 10, fill: "white"});
		Root.appendChild(beatDisplay);
	}

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

