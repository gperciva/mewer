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

import mewer.UI;
import mewer.Exercise;
import mewer.Metronome;

enum Difficulty {
  Tutorial;
  Easy;
  Hard;
}

class Game {
	// peristent objects
	static inline var allowedMetro = [60, 62.5, 75, 80, 93.75, 100, 120];
	var headers : Array<Array<Int>>;
	var ui : mewer.UI;
	var exercise : mewer.Exercise;
	var metronome : mewer.Metronome;
	var drawMain : Dynamic;

	// stable for each game
	var difficulty : Difficulty;
	var passGrade : Int;
	var passNum : Int;
	var gradeScale : Int;

	// changes
	var level : Int;
	var passedExercises : Int;
	var graded : Bool;
	var reload : Bool;

	public function new(drawMainGet : Dynamic) {
		drawMain = drawMainGet;
		headers = loadLevels();

		metronome = new Metronome();
		exercise = new Exercise();
		ui = new UI(exerPrep, exerStart, exerStop, quit);
	}

	function loadLevels() : Array<Array<Int>> {
		var fromFile = haxe.Resource.getString("headers").split(",");
		// remove extra unavoidable element
		fromFile.pop();

		var numLevels = fromFile.length;
		var myHeaders = new Array<Array<Int>>();

		for (i in 0...numLevels) {
			var level = fromFile[i].split(" ");
			var myLevel = new Array<Int>();

			for (j in 0...level.length) {
				myLevel[j] = Std.parseInt(level[j]);
			}
			myHeaders[i] = myLevel;
		}
		return myHeaders;
	}

	function quit(event : Dynamic) {
		metronome.reset();
		exercise.reset();
		ui.reset();
		drawMain();
	}

#if flash9
	public function chooseInput() {
		ui.chooseInput(drawMain);
	}
#end

// ********* PER GAME
	public function start(difficultyGet : Difficulty, levelGet : Int) {
		difficulty = difficultyGet;
		switch (difficulty) {
		case Tutorial:
			passGrade = 50;
			passNum = 1;
			gradeScale = 60;
		case Easy:
			passGrade = 50;
			passNum = 2;
			gradeScale = 60;
		case Hard:
			passGrade = 70;
			passNum = 3;
			gradeScale = 80;
		}

		// loads levels, removes last entry (which is empty)
		level = levelGet;
		passedExercises = 0;
		reload = false;

		exerPrep();
	}

	function exerPrep() {
		graded = false;
		if (reload) {
			exercise.reload();
		} else {
			var bpm = pickbpm(level);
			metronome.set(bpm);
			exercise.load(level, bpm, headers[level]);
		}
		ui.prep();
		if (difficulty == Tutorial)
			ui.showTutorialHelp();
	}

	function exerStart() {
		ui.start();
		metronome.start();
	}

	function exerStop(alignBest:Bool) {
		ui.exerOver();

		metronome.stop();
		var detected = ui.getDetected();

		var grade = exercise.grade(detected, alignBest, gradeScale);
		if (detected.length != exercise.getLength())
			ui.warnOnsets(exercise.getLength(),
				detected.length);
		if (grade > passGrade) {
			passed(grade);
		} else {
			if (!graded) {
				passedExercises--;
				if (passedExercises < 0)
					passedExercises = 0;
				graded = true;
			}
			reload = true;
			ui.showGrade(Fail, grade, level, passedExercises, passNum);
		}
	}

	function passed(grade : Float) {
		if (!graded) {
			passedExercises++;
			reload = false;
		}
		if (passedExercises >= passNum) {
			if (!graded) {
				level++;
				passedExercises = 0;
				graded = true;
			}
			if (difficulty == Tutorial) {
				ui.showGrade(Win, grade, level, passedExercises, passNum);
				ui.showTutorialWin();
				level = 0;
				return;
			}
			var maxLevel = headers.length - 1;
			if (level > maxLevel) {
				ui.showGrade(Win, grade, level, passedExercises, passNum);
				ui.showWin(maxLevel);
				level = maxLevel;
			} else
				ui.showGrade(Advance, grade, level, passedExercises, passNum);
		} else {
			ui.showGrade(Pass, grade, level, passedExercises, passNum);
		}
	}

	function pickbpm(level : Int) : Float {
		var minBPM = headers[level][3];
		var maxBPM = headers[level][4];
		var choices = new List();

		for (i in 0...allowedMetro.length) {
			if ((allowedMetro[i] >= minBPM) &&
			    (allowedMetro[i] <= maxBPM))
				choices.add(allowedMetro[i]);
		}
		// select the item from the list
		var choiceNum = Std.random(choices.length);
		for (i in 0...choiceNum)
			choices.pop();
		var bpm = choices.pop();

		return bpm;
	}
}

