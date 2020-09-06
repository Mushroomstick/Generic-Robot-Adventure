/// @description GAME: Draw GUI Event

switch(room)
{
	case Title:
	    #region Title
			draw_set_color(c_black);
			draw_set_alpha(.25);
			draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
			draw_set_color(c_white);
			draw_set_alpha(1);
	        draw_set_font(global.fnt_lite);
	        draw_set_color(c_white);
	        draw_text_ext_transformed(100, 100, "generic robot adventure!", 10, display_get_width(), 6, 6, 0);
			draw_text_ext_transformed(200, 160, "(olc codejam 2020)", 10, display_get_width(), 4, 4, 0);
	        draw_menu_title(map, cursor);
	    #endregion
	    break;
	case Game:
	    #region Game HUD
			if (instance_exists(obj_player))
			{
				draw_set_color(c_black);
				draw_set_alpha(.5);
				draw_rectangle(0, 0, display_get_width() / 2, display_get_height() / 20, false);
				draw_set_color(c_white);
				draw_set_alpha(1);
				for (var i = 0; i < obj_player.max_hp; i++)
				{
					draw_sprite_ext(spr_health, 0, 16 + i * 16, 16, 1, 1, 0, c_black, .5);
				}
				for (var i = 0; i < obj_player.hp; i++)
				{
					draw_sprite(spr_health, 0, 16 + i * 16, 16);
				}
				draw_set_font(global.fnt_lite);
				draw_text_transformed(16, 40, "att: " + string(obj_player.att), 2, 2, 0);
		
				var _floor = test.cursorZ + 1 == floors ? "final" : string(test.cursorZ + 1);
				draw_text_transformed(200, 16, "floor: " + _floor, 2, 2, 0);
			}
			else
			{
					draw_set_font(global.fnt_lite);
					draw_set_color(c_white);
					draw_text_transformed(200, 200, "press 'attack' to try again!", 3, 3, 0);
			}
		#endregion
      break;
   default:
      break;
}

#region Debug Display
	if (global.debug)
	{
		var _xOff = display_get_gui_width() / 2;
		draw_set_font(global.fnt_lite);
		draw_set_color(c_white);
		draw_set_alpha(1);
		draw_text(_xOff + 10,  20, "debug! ");
		draw_text(_xOff + 50,  20, "u:" + string(global.up));
		draw_text(_xOff + 70,  20, "d:" + string(global.down));
		draw_text(_xOff + 90,  20, "l:" + string(global.left));
		draw_text(_xOff + 110, 20, "r:" + string(global.right));
		draw_text(_xOff + 130, 20, "a:" + string(global.buttA_hold));
		draw_text(_xOff + 150, 20, "b:" + string(global.buttB_hold));
		draw_text(_xOff + 180, 20, "cam_x:" + string(round(x)));
		draw_text(_xOff + 250, 20, "cam_y:" + string(round(y)));
		draw_text(_xOff + 320, 20, "view_w:" + string(view_get_wport(0)));
		draw_text(_xOff + 400, 20, "view_h:" + string(view_get_hport(0)));
   
		draw_text(_xOff + 10,  30, "rm:" + room_get_name(room));
		draw_text(_xOff + 100, 30, "gpad:" + string(pad) + " " + string_lower(gamepad_get_description(pad)));
   
		draw_text(_xOff + 10, 40, "ha:" + string(gamepad_axis_value(pad, gp_axislh)));
		draw_text(_xOff + 70, 40, "va:" + string(gamepad_axis_value(pad, gp_axislv)));
   
		draw_text(_xOff + 10, 50, "fps:" + string(game_get_speed(gamespeed_fps)));
		draw_text(_xOff + 70, 50, "real_fps:" + string(realFPS));
		draw_text(_xOff + 200, 50, "game.dir:" + string(dir));
	}
#endregion