/// @description obj_stairs: Create Event

#region Animation Variables
	depth = -1;
	scale = 1;
	spriteW = 64;
	spriteH = 64;
	xFrame = 0;
	yFrame = 0;
	frameRate = 10;
	//framesPerSec = 60;
    framesPerSec = 120;
	frameTot = 1;
#endregion

#region Create Vertex Buffer
	var _c = c_white;
	pbuffer = vertex_create_buffer();
	vertex_begin(pbuffer, vertex_format);
		var _x1 = x - spriteW / 2;
		var _z1 = -(1 + spriteH);
		var _x2 = x + spriteW / 2;
		var _z2 = -1;
		var _off = spriteW / 64;
		var _x1off = _off * floor(xFrame);
		var _x2off = _off + _off * floor(xFrame);
		var _z1off = _off * yFrame;
		var _z2off = _off + _off * yFrame;
		vertex_add_point(pbuffer, _x1,	y,	_z1,	0, 0, 1,	_x1off,	_z1off,		_c, 1);
		vertex_add_point(pbuffer, _x2,  y,	_z1,	0, 0, 1,	_x2off, _z1off,		_c, 1);
		vertex_add_point(pbuffer, _x2,  y,	_z2,	0, 0, 1,	_x2off, _z2off,		_c, 1);
					
		vertex_add_point(pbuffer, _x2,	y,	_z2,	0, 0, 1,	_x2off, _z2off,		_c, 1);
		vertex_add_point(pbuffer, _x1,	y,	_z2,	0, 0, 1,    _x1off, _z2off,		_c, 1);
		vertex_add_point(pbuffer, _x1,	y,	_z1,	0, 0, 1,    _x1off,	_z1off,		_c, 1);

	vertex_end(pbuffer)
#endregion