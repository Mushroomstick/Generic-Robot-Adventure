/// @description obj_enem01: Create Event

#region Movement Variables
   // walking
      hSpd = 0;
      vSpd = 0;
      maxSpd = .5;
	  curSpd = 0;
      accel = .0625;
   // delta multiplier
      mult = 120;
#endregion

#region State Machine
	enum e_state
	{
		idle,
		chase,
		attack,
		knock,
		home,
		die
	}
	curState = e_state.idle;
	move = false;
	iframe = 0;
	hp = 6;
	att = 1;
	def = 0;
#endregion

#region Animation Variables
	depth = -1;
	scale = 1;
	spriteW = 17;
	spriteH = 17;
	xFrame = 0;
	yFrame = 0;
	frameRate = 10;
	//framesPerSec = 60;
    framesPerSec = 120;
	frameTot = 4;
#endregion

#region Tilemap IDs
   tilSol = layer_tilemap_get_id("Tiles_1");
#endregion

#region Create Vertex Buffer
	var _c = c_white;
	pbuffer = vertex_create_buffer();
	vertex_begin(pbuffer, vertex_format);
		var _x1 = x - spriteW / 2;
		var _z1 = -(1 + spriteH);
		var _x2 = x + spriteW / 2;
		var _z2 = -1;
		var _off = spriteW / 256;
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

/// @function				round_dir(_input)
/// @description			Round value of _input to nearest multiple of 45 within {0, 360}.
/// @param	{real}	_input	Direction value.
function round_dir(_input)
{
	var _dir = 0;
	if (_input >= 337.5 && _input < 382.5)
	{
		_dir = 0;
	}
	else if (_input >= 22.5 && _input < 67.5)
	{
		_dir = 45;
	}
	else if (_input >= 67.5 && _input < 112.5)
	{
		_dir = 90;
	}
	else if (_input >= 112.5 && _input < 157.5)
	{
		_dir = 135;
	}
	else if (_input >= 157.5 && _input < 202.5)
	{
		_dir = 180;
	}
	else if (_input >= 202.5 && _input < 247.5)
	{
		_dir = 225;
	}
	else if (_input >= 247.5 && _input < 292.5)
	{
		_dir = 270;
	}
	else if (_input >= 292.5 && _input < 337.5)
	{
		_dir = 315;
	}
	return _dir % 360;
}