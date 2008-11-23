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


class UIgen {

	static public function xinfButton(
		textGet : String, x : Int, y : Int, width : Int, ?mouseFunc: Dynamic
	) : Group {
		var button = new Group();
		var buttonRect = new Rectangle({
			x:0, y:0, width:width, height:22,
			stroke: "black", fill: Paint.RGBColor(0.8,0.8,0.8),
			});
		button.appendChild(buttonRect);

		var buttonText = new Text({
			x:3, y:17, text: textGet, fill:"black",
			font_size:18
			});
		button.appendChild(buttonText);

		button.transform = new Translate(x,y);
		if (mouseFunc != null) {
			buttonRect.addEventListener(MouseEvent.MOUSE_DOWN,
				mouseFunc);
			buttonText.addEventListener(MouseEvent.MOUSE_DOWN,
				mouseFunc);
		}

		return button;
	}

	static public function xinfButtonSmall(
		textGet : String, x : Int, y : Int, width : Int, ?mouseFunc: Dynamic
	) : Group {
		var button = new Group();
		var buttonRect = new Rectangle({
			x:0, y:0, width:width, height:12,
			stroke: "black", fill: Paint.RGBColor(0.8,0.8,0.8),
			});
		button.appendChild(buttonRect);

		var buttonText = new Text({
			x:2, y:10, text: textGet, fill:"black",
			font_size:10
			});
		button.appendChild(buttonText);

		button.transform = new Translate(x,y);
		if (mouseFunc != null) {
			buttonRect.addEventListener(MouseEvent.MOUSE_DOWN,
				mouseFunc);
			buttonText.addEventListener(MouseEvent.MOUSE_DOWN,
				mouseFunc);
		}

		return button;
	}
}
