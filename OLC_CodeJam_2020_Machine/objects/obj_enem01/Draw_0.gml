/// @description obj_enem01: Draw Event

#region Draw Enemy Shadow
	draw_sprite_ext(spr_enem01, 1, x, y, scale, scale, image_angle, c_white, 1);
#endregion

#region Draw Enemy
	vertex_submit(pbuffer, pr_trianglelist, sprite_get_texture(spr_enem, 0));
#endregion

#region Debug - Draw Collision Box & Path
	if (global.debug)
	{
		draw_set_color(c_yellow);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
		draw_line(x, y, x + lengthdir_x(100, direction), y + lengthdir_y(100, direction));
	}
#endregion