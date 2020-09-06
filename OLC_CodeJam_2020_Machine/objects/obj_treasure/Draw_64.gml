/// @description obj_stairs: Draw GUI Event

if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < 150)
{
	draw_set_font(global.fnt_lite);
	draw_set_color(c_white);
	draw_text_transformed(200, 200, "press 'attack' to go to power up!", 3, 3, 0);
}