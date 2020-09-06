/// @description obj_blade: Draw Event

#region Draw Weapon
	draw_sprite_ext(spr_blade, 0, x, y, image_xscale, 1, image_angle, c_white, 1);
#endregion

#region Debug - Draw Collision Box
	if (global.debug)
	{
		draw_set_color(c_yellow);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	}
#endregion