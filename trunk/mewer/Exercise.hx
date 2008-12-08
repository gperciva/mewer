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

class Exercise {
#if flash9
	static inline var flashVertical : Int = 1;
#elseif js
	static inline var flashVertical : Int = 11;
#end
	var musicArea : Group;
	var resultArea : Group;

	var currentExercise : Int;

	var expected : List<Float>;
	var timeScale : Float;
	var numBeatDivisions : Int;
	var numBeats : Int;

	public function new() {
		musicArea = new Group();
		musicArea.transform = new Translate(0, flashVertical);

		resultArea = new Group();
		resultArea.transform = new Translate(0, 37+flashVertical);
		Root.appendChild(resultArea);

		// do this last so it overwrites resultArea.
		Root.appendChild(musicArea);
	}

	public function reset() {
		musicArea.display = xinf.ony.type.Display.None;
		while (musicArea.childNodes.hasNext())
			musicArea.removeChild(musicArea.childNodes.next());

		resultArea.display = xinf.ony.type.Display.None;
		while (resultArea.childNodes.hasNext())
			resultArea.removeChild(resultArea.childNodes.next());
	}

	public function reload() {
		resultArea.display = xinf.ony.type.Display.None;
		while (resultArea.childNodes.hasNext())
			resultArea.removeChild(resultArea.childNodes.next());
	}

	public function load(level : Int, bpm : Float,
			levelInfo : Array<Int>) {
		reset();

		// get picture
		var numExercises = levelInfo[2];
		var nextExercise: Dynamic;
		do {
			nextExercise = Std.random(numExercises) + 1;
		} while (nextExercise == currentExercise);

		if (nextExercise<10)
			nextExercise = '000' + nextExercise;
		else if (nextExercise<100)
			nextExercise = '00' + nextExercise;
		else if (nextExercise<10)
			nextExercise = '0' + nextExercise;
		var exerName = "data/" + level + "/" + nextExercise;

		// get time scaling
		numBeats = levelInfo[0];	
		numBeatDivisions = levelInfo[1];
		timeScale = 60.0 / bpm / (numBeatDivisions*numBeats) * 4;

		// get expected onsets
		expected = new List();
		var lvlOnsets = haxe.Resource.getString("level"+level).split(" ");
		var exerOnsets = lvlOnsets[nextExercise-1];
		for (i in 0...(numBeatDivisions*numBeats)) {
			if (exerOnsets.charAt(i) == '1') {
				expected.add(i*timeScale);
			}
		}
		// second bar
		for (i in 0...(numBeatDivisions*numBeats)) {
			if (exerOnsets.charAt(i) == '1') {
				expected.add((numBeats*numBeatDivisions+i)*timeScale);
			}
		}

		var img = new Image();
		//img.href = "http://127.0.0.1:80/~gperciva/"+exerName + ".png";
		img.href = exerName + ".png";
		musicArea.appendChild(img);

		musicArea.display = xinf.ony.type.Display.Inline;
	}


	public function grade(detected : List<Float>,
		alignBest : Bool, gradeScale : Int) : Float {

		var difs = new List();

		var ei = expected.iterator();
		var di = detected.iterator();
		var alignE : Float = 0.0;
		var alignD : Float = 0.0;

		// alignment
		var offset;
		if (alignBest) {
			for (i in 0...expected.length) {
				alignE = alignE + ei.next();
			}
			alignE = alignE / expected.length;
			for (i in 0...detected.length) {
				alignD = alignD + di.next();
			}
			alignD = alignD / detected.length;
			offset = alignE - alignD;
		} else {
			offset = -1*detected.first();
		}
		detected = detected.map( function(x) : Float {
			return x + offset; });

		var sum = 0.0;
		ei = expected.iterator();
		di = detected.iterator();
		for (i in 0...expected.length) {
			var e : Float = di.next() - ei.next();
			e = e * e;
			sum = sum + e;
//			difs.add( e );
		}

		// average
		sum = sum / expected.length;

		// scaling
		sum = sum * gradeScale;
		var score = (1-sum)*100.0;

		if (score < 0)
			score = 0;

		score = (Math.round(score*10)) / 10;

		display(detected);
		return score;

	}

	public function getLength() : Int
	{
		return expected.length;
	}

	public function display(detected : List<Float> ) {
  		var offset = 36;
		var height = 240 - flashVertical;


		var fillColor;
		if (detected.length == expected.length)
			fillColor = "white";
		else
			fillColor = "yellow";

		var scale = (480 - offset) / (timeScale*numBeats*numBeatDivisions*2);
		resultArea.appendChild( new Rectangle({
				x: 0, y: 0, width: 480,
				height: height, fill: fillColor}));

		var ei = expected.iterator();
		var di = detected.iterator();

		for (i in 0...expected.length) {
			var center = ei.next() * scale + offset;
			var line = new Rectangle({
				x: center-1, y: 0, width: 3,
				height: (height*2)/3, fill: "black"});
			resultArea.appendChild( line );
		}
		for (i in 0...detected.length) {
			var center = di.next() * scale + offset;
			var line = new Rectangle({
				x: center-1, y: height/3, width: 3,
				height: (height*2)/3, fill: "red"});
			resultArea.appendChild( line );
		}
		resultArea.display = xinf.ony.type.Display.Inline;

	}

}


