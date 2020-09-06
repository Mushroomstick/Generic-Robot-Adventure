/// @description obj_blade: Step Event

if (instance_exists(obj_player))
{
	x = obj_player.x;
	y = obj_player.y;
}
else
{
	instance_destroy();
}

if (image_xscale < 1)
{
	image_xscale += 1 / 20;
}
else
{
	instance_destroy();
}