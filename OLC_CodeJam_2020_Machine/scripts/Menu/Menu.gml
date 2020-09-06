/// @description Menu script

//global.menuMap = 0;

enum menu
{
   nul,
   gam,
   opt,
   qui
}

enum opt
{
   opt,
   vol,
   vid,
   //inp,
   qui
}

enum vol
{
   vol,
   mas,
   mus,
   sfx,
   qui
}

enum vid
{
   vid,
   ful,
   qui
}

//enum inp
//{
//   inp,
//   up,
//   dow,
//   lef,
//   rig,
//   jum,
//   att,
//   qui
//}

function init_menu()
{
   // init top
      global.menuMap[menu.qui] = "quit";
      global.menuMap[menu.opt] = "options";
	  global.menuMap[menu.gam] = "play";
   // init option
      global.optMap[opt.qui] = "back";
      //global.optMap[opt.inp] = "input";
      global.optMap[opt.vid] = "video";
      global.optMap[opt.vol] = "volume";
      global.optMap[opt.opt] = "options";
   // init volume
      global.volMap[vol.qui] = "back";
      global.volMap[vol.sfx] = "sfx";
      global.volMap[vol.mus] = "music";
      global.volMap[vol.mas] = "master";
      global.volMap[vol.vol] = "volume";
   // init video
      global.vidMap[vid.qui] = "back";
      global.vidMap[vid.ful] = "fullscreen";
      global.vidMap[vid.vid] = "video";
   //// init input
   //   global.inpMap[inp.qui] = "back";
   //   global.inpMap[inp.att] = "attack";
   //   global.inpMap[inp.jum] = "jump/enter";
   //   global.inpMap[inp.rig] = "right";
   //   global.inpMap[inp.lef] = "left";
   //   global.inpMap[inp.dow] = "down";
   //   global.inpMap[inp.up]  = "up";
   //   global.inpMap[inp.inp] = "input";
}

function draw_menu_title(_map, _cursor)
{
   var _ca = c_white;
   var _cb = c_black;
   var _loops = array_length(_map);
   draw_set_font(global.fnt_lite);
   draw_set_color(_cb);
   
   for (var i = 1; i < _loops; i++)
   {
      if (i == _cursor)
      {
         draw_set_color(_ca);
         draw_text_transformed(480, 360 + 30 * i, _map[i], 3, 3, 0);
         volume_slider(_map, _cursor);
         draw_set_color(_cb);
      }
      else
      {
         draw_text_transformed(480, 360 + 30 * i, _map[i], 3, 3, 0);
      }
   }
}

function volume_slider(_map, _cursor)
{
   var _ca = c_white;
   var _cb = c_black;
   
   switch(_map)
   {
      case global.vidMap:
         switch(_cursor)
         {
            case vid.ful:
               draw_set_color(_ca);
               var _full = window_get_fullscreen() ? "true" : "false";
               draw_text_transformed(720, 390, _full, 3, 3, 0);
               break;
            default:
               break;
         }
         break;
      case global.volMap: // So many magic numbers...
         switch(_cursor)
         {
            case vol.mas:
               draw_set_color(_cb);
			      draw_rectangle(620, 398, 820, 404, false);
		         draw_set_color(_ca);
			      draw_rectangle(620, 396, 620 + 200 * GAME.masterVol, 406, false);
               break;
            case vol.mus:
               draw_set_color(_cb);
			      draw_rectangle(620, 428, 820, 434, false);
		         draw_set_color(_ca);
			      draw_rectangle(620, 426, 620 + 200 * GAME.musicVol, 436, false);
               break;
            case vol.sfx:
               draw_set_color(_cb);
			      draw_rectangle(620, 458, 820, 464, false);
		         draw_set_color(_ca);
			      draw_rectangle(620, 456, 620 + 200 * GAME.sfxVol, 466, false);
               break;
            default:
               break;
         }
         break;
      default:
         break;
   }
}

/// @function setKeyMap()
/// @description Initialize keyMap array.
function setKeyMap()
{
	global.keyMap[255] = "Undefined"; // Initialise array of key definitions

	// Build key definitions table
	for (var i = 255; i >= 0; i--)
	{
	   	global.keyMap[i] = "Undefined";
	}

	#region Set known characters
		global.keyMap[8]	= "BACKSPACE";
		global.keyMap[9]	= "TAB";
		global.keyMap[12]	= "Numpad 5 (nmlk off)";
		global.keyMap[13]	= "ENTER";
		global.keyMap[19]	= "PAUSE";
		global.keyMap[20]	= "CAPS LOCK";
		global.keyMap[27]	= "ESCAPE";
		global.keyMap[32]	= "SPACE";
		global.keyMap[33]	= "PAGE UP";
		global.keyMap[34]	= "PAGE DOWN";
		global.keyMap[35]	= "END";
		global.keyMap[36]	= "HOME";
		global.keyMap[37]	= "LEFT ARROW";
		global.keyMap[38]	= "UP ARROW";
		global.keyMap[39]	= "RIGHT ARROW";
		global.keyMap[40]	= "DOWN ARROW";
		global.keyMap[45]	= "INSERT";
		global.keyMap[46]	= "DELETE";
		global.keyMap[48]	= "0";
		global.keyMap[49]	= "1";
		global.keyMap[50]	= "2";
		global.keyMap[51]	= "3";
		global.keyMap[52]	= "4";
		global.keyMap[53]	= "5";
		global.keyMap[54]	= "6";
		global.keyMap[55]	= "7";
		global.keyMap[56]	= "8";
		global.keyMap[57]	= "9";
		global.keyMap[65]	= "A";
		global.keyMap[66]	= "B";
		global.keyMap[67]	= "C";
		global.keyMap[68]	= "D";
		global.keyMap[69]	= "E";
		global.keyMap[70]	= "F";
		global.keyMap[71]	= "G";
		global.keyMap[72]	= "H";
		global.keyMap[73]	= "I";
		global.keyMap[74]	= "J";
		global.keyMap[75]	= "K";
		global.keyMap[76]	= "L";
		global.keyMap[77]	= "M";
		global.keyMap[78]	= "N";
		global.keyMap[79]	= "O";
		global.keyMap[80]	= "P";
		global.keyMap[81]	= "Q";
		global.keyMap[82]	= "R";
		global.keyMap[83]	= "S";
		global.keyMap[84]	= "T";
		global.keyMap[85]	= "U";
		global.keyMap[86]	= "V";
		global.keyMap[87]	= "W";
		global.keyMap[88]	= "X";
		global.keyMap[89]	= "Y";
		global.keyMap[90]	= "Z";
		global.keyMap[91]	= "WINDOW KEY";
		global.keyMap[96]	= "NUMPAD 0";
		global.keyMap[97]	= "NUMPAD 1";
		global.keyMap[98]	= "NUMPAD 2";
		global.keyMap[99]	= "NUMPAD 3";
		global.keyMap[100]	= "NUMPAD 4";
		global.keyMap[101]	= "NUMPAD 5";
		global.keyMap[102]	= "NUMPAD 6";
		global.keyMap[103]	= "NUMPAD 7";
		global.keyMap[104]	= "NUMPAD 8";
		global.keyMap[105]	= "NUMPAD 9";
		global.keyMap[106]	= "NUMPAD *";
		global.keyMap[107]	= "NUMPAD +";
		global.keyMap[109]	= "NUMPAD -";
		global.keyMap[110]	= "NUMPAD .";
		global.keyMap[111]	= "NUMPAD /";
		global.keyMap[112]	= "F1";
		global.keyMap[113]	= "F2";
		global.keyMap[114]	= "F3";
		global.keyMap[115]	= "F4";
		global.keyMap[116]	= "F5";
		global.keyMap[117]	= "F6";
		global.keyMap[118]	= "F7";
		global.keyMap[119]	= "F8";
		global.keyMap[120]	= "F9";
		global.keyMap[121]	= "F10";
		global.keyMap[122]	= "F11";
		global.keyMap[123]	= "F12";
		global.keyMap[144]	= "NUM LOCK";
		global.keyMap[145]	= "SCROLL LOCK";
		global.keyMap[160]	= "SHIFT (left)";
		global.keyMap[161]	= "SHIFT (right)";
		global.keyMap[162]	= "CTRL (left)";
		global.keyMap[163]	= "CTRL (right)";
		global.keyMap[164]	= "ALT (left)";
		global.keyMap[165]	= "ALT (right)";
		global.keyMap[186]	= ";";
		global.keyMap[187]	= "=";
		global.keyMap[188]	= ",";
		global.keyMap[189]	= "-";
		global.keyMap[190]	= ".";
		global.keyMap[191]	= "?";
		global.keyMap[192]	= "~";
		global.keyMap[219]	= "[";
		global.keyMap[220]	= "\ ";
		global.keyMap[221]	= "]";
		global.keyMap[222]	= "'";
	#endregion
}
