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

class ExtraMetro
{
	static var cnx = null;

	static function main()
	{
		var ctx = new haxe.remoting.Context();
		ctx.addObject("ExtraMetro",ExtraMetro);
		cnx = haxe.remoting.ExternalConnection.flashConnect("default","myFlashObject",ctx);
	}

	static function start(tempo:Int)
	{
		var writeDiv = js.Lib.document.getElementById("metro");
		writeDiv.innerHTML = '<img src="metro/metro-' + tempo + '.gif">';
	}

	static function stop()
	{
		var writeDiv = js.Lib.document.getElementById("metro");
		writeDiv.innerHTML = '<img src="metro/nobeat.gif">';
	}
}

