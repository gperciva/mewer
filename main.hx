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

import mewer.Game;
import mewer.UIgen;
import mewer.Messages;

import Xinf;

class Main {
	var mainWindow : Group;
	var game : Game;

	public function new() {
		game = new Game(drawMain);
		mainWindow = null;
		drawMain();
	}

	public function drawMain(?event : Dynamic) {
		clearMain();
		mainWindow = new Group();
		mainWindow.transform = new Translate(50, 50);
		mainWindow.appendChild(UIgen.xinfButton(
			"Tutorial", 0,0,90, selectTutorial ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Easy", 0,40,90, selectEasy ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Hard", 0,80,90, selectHard ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Tips", 0,120,90, selectTips ));
		Root.appendChild(mainWindow);
	}

        function clearMain() {
		if (mainWindow != null) {
                	Root.removeChild(mainWindow);
                	mainWindow = null;
		}
#if flash9
                flash.Lib.current.stage.focus = flash.Lib.current;
#end
        }

	function selectTutorial(event : MouseEvent) {
		clearMain();
		game.start(Tutorial,0);
	}

	function selectEasy(event : MouseEvent) {
		clearMain();
		game.start(Easy,1);
	}

	function selectHard(event : MouseEvent) {
		clearMain();
		game.start(Hard,1);
	}

	function selectTips(event : MouseEvent) {
		clearMain();
		mainWindow = Messages.getTips(drawMain);
		Root.appendChild(mainWindow);
	}

	public static function main() {
		new Main();
		Root.main();
	}
}


