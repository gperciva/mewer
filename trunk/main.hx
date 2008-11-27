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
#if flash9
		game.chooseInput();
#else
		drawMain();
#end
	}

	public function drawMain(?event : Dynamic) {
		clearMain();
		mainWindow = new Group();
		mainWindow.appendChild(new Text({
			x:100, y:10, fill:"black", font_size:48,
			text:"MEWER"}));

		mainWindow.transform = new Translate(50, 50);
		mainWindow.appendChild(UIgen.xinfButton(
			"Tutorial", 0,20,110, selectTutorial ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Easy", 0,60,110, selectEasy ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Hard", 0,100,110, selectHard ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Tips", 0,140,110, selectTips ));
#if flash9
		mainWindow.appendChild(UIgen.xinfButton(
			"Input source", 0,180,110, selectInput));
#end
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

#if flash9
	function selectInput(event : MouseEvent) {
		clearMain();
		game.chooseInput();
	}
#end


	public static function main() {
		new Main();
		Root.main();
	}
}


