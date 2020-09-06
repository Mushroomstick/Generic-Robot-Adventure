/// @description obj_health: Step Event

if (instance_exists(obj_player) && place_meeting(x, y, obj_player))
{
	if (obj_player.hp < obj_player.max_hp)
	{
		obj_player.hp += 1;
	}
	instance_destroy();
}