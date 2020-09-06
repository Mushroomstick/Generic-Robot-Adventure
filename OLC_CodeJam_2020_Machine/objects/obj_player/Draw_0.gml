/// @description obj_player: Draw Event

#region Draw Player Shadow
	draw_sprite(spr_player, 1, x, y);
#endregion

#region Draw Weapon Shadow
	if (instance_exists(obj_blade))
	{
		draw_sprite_ext(spr_blade, 1, x, y, obj_blade.image_xscale, 1, obj_blade.image_angle, c_white, 1);
	}
#endregion

#region Draw Player
	vertex_submit(pbuffer, pr_trianglelist, sprite_get_texture(spr_play, 0));
#endregion

#region Debug - Draw Collision Box
	if (global.debug)
	{
		draw_set_color(c_yellow);
		draw_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, true);
	}
#endregion