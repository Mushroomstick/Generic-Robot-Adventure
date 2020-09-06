/// @description obj_blade: Create Event

if (instance_exists(obj_player))
{
	depth = -7;
	x = obj_player.x;
	y = obj_player.y;
	image_xscale = 0;
	direction = obj_player.direction + GAME.dir + 90;
	image_angle = direction;
}
else
{
	instance_destroy();
}