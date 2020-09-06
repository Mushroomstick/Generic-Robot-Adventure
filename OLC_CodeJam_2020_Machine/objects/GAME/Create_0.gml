/// @description GAME: Create Event

window_set_size(display_get_width() / 2, display_get_height() / 2);
display_set_gui_size(display_get_width() / 2, display_get_height() / 2);
game_set_speed(120, gamespeed_fps);
gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_alphatestenable(true);

randomize();

#region Camera Variables
	x = 320;
	y = 180;
	z = 300;
	dir = 270;
	dirTarg = dir;
	offx = 0;
	offy = 0;
	yy = 300;
#endregion

#region Audio
	audio_listener_orientation(0,1,0,0,0,1);
	audio_listener_position(x, y, 0);
	masterVol	= 0.8;
	musicVol	= 0.8;
	sfxVol		= 0.8;
	audio_group_load(music);
	audio_group_load(sfx);
	audio_group_set_gain(music, musicVol * masterVol, 0);
	audio_group_set_gain(sfx, sfxVol * masterVol, 0);
#endregion

#region Debug Variables
   global.debug = false;
   realFPS = 0;
   fpsQueue = ds_queue_create();
#endregion

#region Fonts
	global.fnt_dmg = font_add_sprite_ext(spr_font_damage, "0123456789.,;:'?!_", true, 1);
	global.fnt_lite = font_add_sprite_ext(spr_font_light, "abcdefghijklmnopqrstuvwxyz0123456789.,;:'?!_-/()", true, 1);
#endregion

#region Gamepad Variable
	pad = 0;
#endregion
	
#region Generate Level
	floors = 3
	test = new Level(5, 5, floors);
	test.reset_level();
	test.build_level(0, 0, 0);
#endregion

#region Menu Variables
	setKeyMap();
	init_menu();
	cursor = 1;
	map = global.menuMap;
#endregion