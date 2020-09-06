/// @description GAME: Step Event

audio_listener_position(x, y, 0);

#region Debug Step
	if (keyboard_check(vk_control) && keyboard_check_pressed(ord("D")))
	{
	    global.debug = global.debug == true ? false : true;
	}
	if (global.debug)
	{
		// calculate real fps
		    ds_queue_enqueue(fpsQueue, fps_real);
		    if (ds_queue_size(fpsQueue) > 120)
		    {
		        var _avg = 0;
		        for (var i = 0; i < 120; i++)
		        {
		        _avg += ds_queue_dequeue(fpsQueue);
		        }
		        realFPS = _avg / 120;
		    }
		// zoom map
		  	var zMov = keyboard_check(ord("Z")) - keyboard_check(ord("X"));
			if (zMov != 0)
			{
			   if (zMov == 1 && z < 1000)
			   {
			      z += zMov * 3;
			   }
			   else if (zMov == -1 && z > -32)
			   {
			      z += zMov * 3;
			   }
			}
			if (room == Game)
			{
				// spawn boss
					if (keyboard_check(vk_control) && keyboard_check_pressed(ord("E")))
					{
						var _boss = instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_enem01);
						_boss.scale = 4;
						_boss.hp = 20;
					}
				// spawn enemy
					if (keyboard_check(vk_control) && keyboard_check_pressed(ord("R")))
					{
						var _boss = instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_enem01);
					}
				// spawn treasure
					if (keyboard_check(vk_control) && keyboard_check_pressed(ord("T")))
					{
						var _boss = instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_treasure);
					}
			}
	}
	else if(ds_queue_empty(fpsQueue))
	{
	    ds_queue_clear(fpsQueue);
	}
	else
	{
		z = 300;
	}
#endregion

#region Inputs
   global.up         = keyboard_check(ord("W"))         || gamepad_button_check(pad, gp_padu) || gamepad_axis_value(pad, gp_axislv) < 0;
   global.down       = keyboard_check(ord("S"))         || gamepad_button_check(pad, gp_padd) || gamepad_axis_value(pad, gp_axislv) > 0;
   global.up_press   = keyboard_check_pressed(ord("W")) || gamepad_button_check_pressed(pad, gp_padu);
   global.down_press = keyboard_check_pressed(ord("S")) || gamepad_button_check_pressed(pad, gp_padd);
   global.left       = keyboard_check(ord("A"))         || gamepad_button_check(pad, gp_padl) || gamepad_axis_value(pad, gp_axislh) < 0;
   global.right      = keyboard_check(ord("D"))         || gamepad_button_check(pad, gp_padr) || gamepad_axis_value(pad, gp_axislh) > 0;
   global.left_press = keyboard_check_pressed(ord("A")) || gamepad_button_check_pressed(pad, gp_padl);
   global.right_press= keyboard_check_pressed(ord("D")) || gamepad_button_check_pressed(pad, gp_padr);
   global.buttA_hold = keyboard_check(vk_space)         || gamepad_button_check(pad, gp_face1);
   global.buttB_hold = keyboard_check(vk_shift)         || gamepad_button_check(pad, gp_face3);
   global.buttA      = keyboard_check_pressed(vk_space) || gamepad_button_check_pressed(pad, gp_face1);
   global.buttB      = keyboard_check_pressed(vk_shift) || gamepad_button_check_pressed(pad, gp_face3);
   global.buttL		 = keyboard_check_pressed(ord("Q")) || gamepad_button_check_pressed(pad, gp_shoulderl);
   global.buttR		 = keyboard_check_pressed(ord("E")) || gamepad_button_check_pressed(pad, gp_shoulderr);
   global.buttMap	 = keyboard_check_pressed(vk_tab)	|| gamepad_button_check_pressed(pad, gp_select);
#endregion


switch(room)
{
	case Title:
	    #region Title
	        if (!audio_is_playing(mus_loop))
	        {
				audio_play_sound(mus_loop, 1, true);
	        }
	        var _loops = array_length(map) - 1;
	        if (global.up_press)
	        {
		        cursor--;
		        audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
	        }
	        else if (global.down_press)
	        {
		        cursor++;
		        audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
	        }
	        if (cursor < 1)
	        {
				cursor = _loops;
	        }
	        else if (cursor > _loops)
	        {
				cursor = 1;
	        }
	        #region Menu Logic
	        switch(map)
	        {
	            case global.menuMap:
	                #region Top
	                    if (global.buttA || global.buttB)
	                    {
		                    switch(cursor)
		                    {
		                        case menu.gam:
		                            if (audio_is_playing(mus_loop))
		                            {
		                                audio_stop_sound(mus_loop);
		                            }
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            room_goto(Game);
		                            break;
		                        case menu.opt:
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.optMap;
		                            cursor = opt.vol;
		                            break;
		                        case menu.qui:
		                            game_end();
		                            break;
		                        default:
		                            map = global.menuMap;
		                            break;
		                    }
	                    }
	                #endregion
	                break;
	            case global.optMap:
	                #region Option
	                    if (global.buttA || global.buttB)
	                    {
		                    switch(cursor)
		                    {
		                        case opt.vol:
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.volMap;
		                            cursor = vol.mas;
		                            break;
		                        case opt.vid:
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.vidMap;
		                            cursor = vid.ful;
		                            break;
		                        //case opt.inp:
		                        //    audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                        //    map = global.inpMap;
		                        //    cursor = inp.up;
		                        //    break;
		                        case opt.qui:
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.menuMap;
		                            cursor = menu.opt;
		                            break;
		                        default:
		                            break;
		                    }
	                    }
	                #endregion
	                break;
	            case global.volMap:
	                #region Volume
	                    switch(cursor)
	                    {
		                    case vol.mas:
		                        if (global.left_press && masterVol > 0)
		                        {
		                            masterVol -= 0.05;
		                            audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
		                        }
		                        if (global.right_press && masterVol < 1)
		                        {
		                            masterVol += 0.05;
		                            audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
		                        }
		                        audio_group_set_gain(music, musicVol * masterVol, 0);
			                    audio_group_set_gain(sfx, sfxVol * masterVol, 0);
		                        break;
		                    case vol.mus:
		                        if (global.left_press && musicVol > 0)
		                        {
		                            musicVol -= 0.05;
		                        }
		                        if (global.right_press && musicVol < 1)
		                        {
		                            musicVol += 0.05;
		                        }
		                        audio_group_set_gain(music, musicVol * masterVol, 0);
		                        break;
		                    case vol.sfx:
		                        if (global.left_press && sfxVol > 0)
		                        {
		                            sfxVol -= 0.05;
		                            audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
		                        }
		                        if (global.right_press && sfxVol < 1)
		                        {
		                            sfxVol += 0.05;
		                            audio_play_sound_at(snd_menuBlip, x, y, 0, 50, 100, 1, false, 1);
		                        }
		                        audio_group_set_gain(sfx, sfxVol * masterVol, 0);
		                        break;
		                    case vol.qui:
		                        if (global.buttA || global.buttB)
		                        {
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.optMap;
		                            cursor = opt.vol;
		                        }
		                        break;
		                    default:
		                        break;
		                }
		            #endregion
	                break;
	            case global.vidMap:
	                #region Video
	                    switch(cursor)
	                    {
		                    case vid.ful:
		                        if (global.buttA || global.buttB)
		                        {
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            if (!window_get_fullscreen())
		                            {
		                                window_set_fullscreen(true);
		                            }
		                            else
		                            {
		                                window_set_fullscreen(false);
		                            }
		                        }
		                        break;
		                    case vid.qui:
		                        if (global.buttA || global.buttB)
		                        {
		                            audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		                            map = global.optMap;
		                            cursor = opt.vid;
		                        }
		                        break;
		                    default:
		                        break;
	                    }
	                #endregion
	                break;
	            //case global.inpMap:
	            //    #region Input
	            //        switch(cursor)
	            //        {
		        //            case inp.up:
		        //                // TODO up input map
		        //                break;
		        //            case inp.dow:
		        //                // TODO down input map
		        //                break;
		        //            case inp.lef:
		        //                // TODO left input map
		        //                break;
		        //            case inp.rig:
		        //                // TODO right input map
		        //                break;
		        //            case inp.jum:
		        //                // TODO jump/enter input map
		        //                break;
		        //            case inp.att:
		        //                // TODO attack input map
		        //                break;
		        //            case inp.qui:
		        //                if (global.buttA)
		        //                {
		        //                    audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
		        //                    map = global.optMap;
		        //                    cursor = opt.inp;
		        //                }
		        //                break;
		        //            default:
		        //                break;
	            //        }
	            //    #endregion
	            //    break;
	            default:
	                break;
	        }
	        #endregion
	    #endregion
	    break;
	case Game:
		#region Game
			if (keyboard_check_pressed(vk_escape))
			{
				room_goto(Title);
			}
			#region Level Rotation
				dirTarg += (global.buttL - global.buttR) * 90;
				if (dir != dirTarg)
				{
					if (dir > 360)
					{
						dir -= 360;
						dirTarg -= 360;
					}
					else if (dir < 0)
					{
						dir += 360;
						dirTarg += 360;
					}
					dir += sign(dirTarg - dir);
				}
				else if (dir > 360)
				{
					dir %= 360;
				}
				offx = lengthdir_x(yy, dir);
				offy = lengthdir_y(yy, dir);
			#endregion

			#region Re-generate Level
				if (!global.debug && keyboard_check(vk_control) && keyboard_check_pressed(ord("R")))
				{
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
				}
			#endregion
	
			#region Navigate Level
				if (instance_exists(obj_player))
				{
					if (obj_player.x > 1280)
					{
						if (!instance_exists(obj_enem01))
					    {
					        test.level[test.cursorZ].layout[test.cursorY][test.cursorX].threat = false;
					    }
						obj_player.x -= 640;
						test.build_level(1, 0, 0);
					}
					if (obj_player.x < 640)
					{
						if (!instance_exists(obj_enem01))
					    {
					        test.level[test.cursorZ].layout[test.cursorY][test.cursorX].threat = false;
					    }
						obj_player.x += 640;
						test.build_level(-1, 0, 0);
					}
					if (obj_player.y > 720)
					{
						if (!instance_exists(obj_enem01))
					    {
					        test.level[test.cursorZ].layout[test.cursorY][test.cursorX].threat = false;
					    }
						obj_player.y -= 320;
						test.build_level(0, 1, 0);
					}
					if (obj_player.y < 400)
					{
						if (!instance_exists(obj_enem01))
					    {
					        test.level[test.cursorZ].layout[test.cursorY][test.cursorX].threat = false;
					    }
						obj_player.y += 320;
						test.build_level(0, -1, 0);
					}
				}
				else if (global.buttA || global.buttB)
				{
					room_restart();
				}
			#endregion
		#endregion
	    break;
	default:
	    break;
}


