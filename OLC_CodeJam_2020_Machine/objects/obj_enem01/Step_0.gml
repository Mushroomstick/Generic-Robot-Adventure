/// @description obj_enem01: Step Event

#region Delta Time Stuff
	var _mult = keyboard_check(vk_shift) ? mult / 10 : mult;
	var delta = (delta_time / 1000000) * _mult;
	var _accel = accel * delta;
	var _max = maxSpd * delta;
		//hSpd = keyboard_check_pressed(vk_shift) || keyboard_check_released(vk_shift) ? hSpd * delta : hSpd;
		//vSpd = keyboard_check_pressed(vk_shift) || keyboard_check_released(vk_shift) ? vSpd * delta : vSpd;
		//curSpd = keyboard_check_pressed(vk_shift) || keyboard_check_released(vk_shift) ? curSpd * delta : curSpd;
#endregion

#region Death / Damage
	if (hp < 1)
	{
		curState = e_state.die;
	}
	else if (iframe < 1 && place_meeting(x, y, obj_blade))
	{
		hp -= obj_player.att - def;
		curState = e_state.knock;
		iframe = 60;
		direction = obj_blade.direction;
		audio_play_sound_at(snd_hit, x, y, 0, 50, 100, 1, false, 1);
	}
#endregion

#region State Machine
	switch (curState)
	{
		case e_state.idle:
			if (instance_exists(obj_player))
			{
				if (point_distance(x, y, obj_player.x, obj_player.y) < 200)
				{
					curState = e_state.chase;
				}
			}
			break;
		case e_state.chase:
			if (instance_exists(obj_player))
			{
				if (point_distance(x, y, obj_player.x, obj_player.y) < 300)
				{
					direction = point_direction(x, y, obj_player.x, obj_player.y);// + GAME.dir;
					move = true;
				}
				else
				{
					move = false;
				}
			}
			else
			{
				move = false;
				curState = e_state.home;
			}
			break;
		case e_state.attack:
			
			break;
		case e_state.knock:
			if (iframe > 0)
			{
				iframe--;
			}
			else
			{
				curState = e_state.idle;
			}
			break;
		case e_state.home:
			
			break;
		case e_state.die:
			if (random_range(0, 10) > 8)
			{
				instance_create_layer(x, y, "Instances", obj_health);
			}
			audio_play_sound_at(snd_death, x, y, 0, 50, 100, 1, false, 1);
			instance_destroy();
			exit;
			break;
		default:
			break;
	}
#endregion

#region Movement
	if (move)
	{
		if (curSpd >= _max)
		{
			curSpd = _max;
		}
		else
		{
			curSpd += _accel;
		}
	}
	else
	{
		if (curSpd <= _accel)
		{
			curSpd = 0;
		}
		else
		{
			curSpd -= _accel;
		}
	}
	hSpd = lengthdir_x(curSpd, direction);
	vSpd = lengthdir_y(curSpd, direction);
#endregion

#region Attack
	//if (global.buttB && !instance_exists(obj_blade))
	//{
	//	instance_create_layer(x, y, "Instances", obj_blade);
	//}
#endregion

#region Collision
   if (hSpd != 0)
   {
      if (tile_meeting(x + hSpd, y, tilSol))
      {
         while (!tile_meeting(x + sign(hSpd), y, tilSol))
         {
            x += sign(hSpd);
         }
         hSpd = 0;
      }
	  if (place_meeting(x + hSpd, y, obj_enem01))
	  {
		  while (!place_meeting(x + sign(hSpd), y, obj_enem01))
         {
            x += sign(hSpd);
         }
         hSpd = 0;
	  }
	  if (instance_exists(obj_player) && place_meeting(x + hSpd, y, obj_player))
	  {
		  while (!place_meeting(x + sign(hSpd), y, obj_player))
         {
            x += sign(hSpd);
         }
         hSpd = 0;
	  }
   }
   x += hSpd;

   if (vSpd != 0)
   {
      if (tile_meeting(x, y + vSpd, tilSol))
      {
         while (!tile_meeting(x, y + sign(vSpd), tilSol))
         {
            y += sign(vSpd);
         }
         vSpd = 0;
      }
	  if (place_meeting(x, y + vSpd, obj_enem01))
      {
         while (!place_meeting(x, y + sign(vSpd), obj_enem01))
         {
            y += sign(vSpd);
         }
         vSpd = 0;
      }
	  if (instance_exists(obj_player) && place_meeting(x, y + vSpd, obj_player))
      {
         while (!place_meeting(x, y + sign(vSpd), obj_player))
         {
            y += sign(vSpd);
         }
         vSpd = 0;
      }
   }
   y += vSpd;
#endregion

#region Animation
	if (hSpd != 0 || vSpd != 0)
	{
        xFrame += frameRate / framesPerSec;
		if (xFrame >= frameTot)
		{
			xFrame = 0;
		}
		yFrame = round_dir(direction) / 45;
	}
	else
	{
		xFrame = 0;
	}
	
	// Update Vertex Buffer
	var _c = c_white;
	vertex_begin(pbuffer, vertex_format);
		var _x1 = x + lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
		var _y1 = y + lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
		var _z1 = -(1 + spriteH * scale);
		var _x2 = x - lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
		var _y2 = y - lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
		var _z2 = -1;
		var _off = spriteW / 256;
		var _x1off = _off * floor(xFrame);
		var _x2off = _off + _off * floor(xFrame);
		var _z1off = _off * yFrame;
		var _z2off = _off + _off * yFrame;
		
		vertex_add_point(pbuffer, _x1, _y1, _z1,	0, 0, 1,	_x1off,	_z1off,		_c, 1);
		vertex_add_point(pbuffer, _x2, _y2, _z1,	0, 0, 1,	_x2off, _z1off,		_c, 1);
		vertex_add_point(pbuffer, _x2, _y2, _z2,	0, 0, 1,	_x2off, _z2off,		_c, 1);
					
		vertex_add_point(pbuffer, _x2, _y2, _z2,	0, 0, 1,	_x2off, _z2off,		_c, 1);
		vertex_add_point(pbuffer, _x1, _y1, _z2,	0, 0, 1,    _x1off, _z2off,		_c, 1);
		vertex_add_point(pbuffer, _x1, _y1, _z1,	0, 0, 1,    _x1off,	_z1off,		_c, 1);

	vertex_end(pbuffer)
#endregion