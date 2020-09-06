/// @description obj_stairs: Step Event

if (instance_exists(obj_player) && point_distance(x, y, obj_player.x, obj_player.y) < 150 && (global.buttA || global.buttB))
{
	if (GAME.test.cursorZ + 1 >= GAME.floors)
	{
		room_goto(Title);
	}
	else
	{
		GAME.test.build_level(0, 0, 1);
	}
	exit;
}

#region Update Vertex Buffer
	var _c = c_white;
	vertex_begin(pbuffer, vertex_format);
		var _x1 = x + lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
		var _y1 = y + lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
		var _z1 = -(1 + spriteH * scale);
		var _x2 = x - lengthdir_x((spriteW * scale) / 2, GAME.dir - 90);
		var _y2 = y - lengthdir_y((spriteW * scale) / 2, GAME.dir - 90);
		var _z2 = -1;
		var _off = spriteW / 64;
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