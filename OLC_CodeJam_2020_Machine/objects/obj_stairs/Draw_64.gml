/// @description obj_stairs: Draw GUI Event

#region Draw Stairs Text
	if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < 150)
	{
		draw_set_font(global.fnt_lite);
		draw_set_color(c_white);
		if (GAME.test.cursorZ + 1 >= GAME.floors)
		{
			draw_text_transformed(200, 200, "you win!", 3, 3, 0);
			draw_text_transformed(200, 230, "press 'attack' to return to the title screen!", 3, 3, 0);
		}
		else
		{
			draw_text_transformed(200, 200, "press 'attack' to go to next floor!", 3, 3, 0);
		}
	}
#endregion