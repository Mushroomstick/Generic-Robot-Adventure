/// @description obj_stairs: Step Event

if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < 150 && (global.buttA || global.buttB))
{
	obj_player.att += 1;
	GAME.test.level[GAME.test.cursorZ].layout[GAME.test.cursorY][GAME.test.cursorX].threat = false;
	audio_play_sound_at(snd_menuSelect, x, y, 0, 50, 100, 1, false, 1);
	instance_destroy();
	exit;
}

var _c = c_white;
vertex_begin(pbuffer, vertex_format);
	var _x1 = x + lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
	var _y1 = y + lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
	var _z1 = -(1 + spriteH * scale);
	var _x2 = x - lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
	var _y2 = y - lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
	var _z2 = -1;
	var _off = spriteW / 128;
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