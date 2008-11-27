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

import Xinf;

class Main {
	var mainWindow : Group;
	var game : Game;
//	var zoomToLevel : TextArea;

	public function new() {
		game = new Game(drawMain);
		drawMain();
	}

	public function drawMain() {
		mainWindow = new Group();
		mainWindow.transform = new Translate(50, 50);
		mainWindow.appendChild(UIgen.xinfButton(
			"Easy", 0,0,90, selectEasy ));
		mainWindow.appendChild(UIgen.xinfButton(
			"Hard", 0,40,90, selectHard ));
		Root.appendChild(mainWindow);

/*
		zoomToLevel = new TextArea({x: 50, y: 70});
		//zoomToLevel.transform = new Translate(0,60);
		zoomToLevel.text = "Zoom to level";
		zoomToLevel.width = 100;
		zoomToLevel.height = 20;
		zoomToLevel.editable = xinf.ony.type.Editability.Simple;
		mainWindow.appendChild(zoomToLevel);
*/
	}

        function clearMain(event : MouseEvent) {
                Root.removeChild(mainWindow);
                mainWindow = null;
#if flash9
                flash.Lib.current.stage.focus = flash.Lib.current;
#end
        }

	function selectEasy(event : MouseEvent) {
		clearMain(null);
		game.start(Easy,1);
	}

	function selectHard(event : MouseEvent) {
		clearMain(null);
		game.start(Hard,1);
	}

	public static function main() {
		new Main();
		Root.main();
	}
}

