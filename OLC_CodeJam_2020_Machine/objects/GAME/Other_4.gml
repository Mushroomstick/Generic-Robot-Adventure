/// @description GAME: Room Start Event

switch (room)
{
	case Title:
		test.reset_level();
		test.build_level(0, 0, 0);
		x = 1920 / 2;
		y = 1080 / 2;
		offx = lengthdir_x(yy, dir);
		offy = lengthdir_y(yy, dir);
		break;
	case Game:
		test.reset_level();
		test.build_level(0, 0, 0);
		if (instance_exists(obj_player))
		{
			obj_player.x = 1920 * .5;
			obj_player.y = 1080 * .5;
		}
		else
		{
			instance_create_layer(1920 * .5, 1080 * .5, "Instances", obj_player);
		}
		break;
	default:
		break;
}