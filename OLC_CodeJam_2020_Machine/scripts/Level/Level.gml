#region Constants/Enums/Etc.
	#macro GRID_W 20
	#macro GRID_H 10

	enum exits
	{
		none = 0x00,
		N	 = 0x01,
		W	 = 0x02,
		NW	 = 0x03,
		S	 = 0x04,
		NS	 = 0x05,
		WS	 = 0x06,
		NWS	 = 0x07,
		E	 = 0x08,
		NE	 = 0x09,
		WE	 = 0x0A,
		NWE	 = 0x0B,
		SE	 = 0x0C,
		NSE	 = 0x0D,
		WSE	 = 0x0E,
		NWSE = 0x0F,
		UP,
		DOWN,
		PEND,
		TREASURE,
		MIDBOSS,
		blank
	}
	
	/* Had to move global.lev_buff initialization to Vertex_Stuff */
		//global.lev_buff = vertex_create_buffer();
		//vertex_begin(global.lev_buff, vertex_format);
		//vertex_end(global.lev_buff)
	
#endregion

/// @function				Level(_width, _height, _floors)
/// @description			Level Struct.
/// @param	{real}	_width	Horizontal dimension.
/// @param	{real}	_height	Vertical dimension.
/// @param	{real}	_floors	Number of floors.
function Level(_width, _height, _floors) constructor
{
	/// @function				Floor(_width, _height)
	/// @description			Floor struct - scoped to Level.
	/// @param	{real}	_width	Horizontal dimension.
	/// @param	{real}	_height	Vertical dimension.
	function Floor(_width, _height) constructor
	{
		/// @function			Room(_x, _y)
		/// @description		Room struct - scoped to Floor.
		/// @param	{real}	_x	Horizontal coordinate.
		/// @param	{real}	_y	Vertical coordinate.
		function Room(_x, _y) constructor
		{
			/* Begin Room Initialization */
				coord_x = _x;
				coord_y = _y;
				doors = exits.none;
				stairs = exits.none;
				live = false;
				threat = true;
				obstacles = irandom_range(0, 4);
				enemies = irandom_range(0, 4);
			/* End Room Initialization */
			
			#region Room Functions
				/// @function				build_room(_xOff, _yOff)
				/// @description			Write room data to vertex buffer.
				/// @param	{real}	_xOff	Horizontal offset.
				/// @param	{real}	_yOff	Vertical offset.
				function build_room(_xOff, _yOff)
				{
					if (doors == exits.N || doors == exits.W || doors == exits.S || doors == exits.E)
					{
						var _plan = floor_plan(doors, 0);
					}
					else
					{
						var _plan = floor_plan(doors, obstacles);
					}
				
					var _c = c_white;
					var _w = TILE_W;
					var _h = TILE_H;
					var _d = TILE_D;
					
					if (live)
					{
						if (threat)
						{
							if (stairs == exits.UP || stairs == exits.MIDBOSS)
							{
								var _boss = instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_enem01);
								_boss.scale = 4;
								_boss.hp = 20;
							}
							else if(stairs == exits.TREASURE)
							{
								instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_treasure);
							}
						}
						else if (stairs == exits.UP)
						{
							instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_stairs);
						}
					}
					
					for (var i = 0; i < GRID_H; i++)
					{
						for (var j = 0; j < GRID_W; j++)
						{
							var _xA = (_xOff + j) * _w;
							var _xB = (_xOff + j) * _w + _w;
							var _yA = (_yOff + i) * _h;
							var _yB = (_yOff + i) * _h + _h;
							
							if (_plan[i][j] == 1 && live && threat)
							{
								instance_create_layer(_xA + 8, _yA + 16, "Instances", obj_enem01);
							}
							if (_plan[i][j] > 1)
							{
								var lay_id = layer_get_id("Tiles_1");
						        var map_id = layer_tilemap_get_id(lay_id);
						        tilemap_set(map_id, 1, _xOff + j, _yOff + i);// + 1);
				
								vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,  .25, .25,	_c, 1);
								vertex_add_point(global.lev_buff, _xB,  _yA, _d,  0, 0, 1,   .5, .25,	_c, 1);
								vertex_add_point(global.lev_buff, _xB,  _yB, _d,  0, 0, 1,   .5,  .5,	_c, 1);
					
								vertex_add_point(global.lev_buff, _xB,	_yB, _d,  0, 0, 1,   .5,   .5,	_c, 1);
								vertex_add_point(global.lev_buff, _xA,	_yB, _d,  0, 0, 1,  .25,   .5,	_c, 1);
								vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,  .25,  .25,	_c, 1);
							}
							else
							{
								var lay_id = layer_get_id("Tiles_1");
						        var map_id = layer_tilemap_get_id(lay_id);
						        tilemap_set(map_id, 0, _xOff + j, _yOff + i);// + 1);
				
								// floor
								vertex_add_point(global.lev_buff, _xA,	_yA,  0,  0, 0, 1,  0,   0,		_c, 1);
								vertex_add_point(global.lev_buff, _xB,  _yA,  0,  0, 0, 1,  .25, 0,		_c, 1);
								vertex_add_point(global.lev_buff, _xB,  _yB,  0,  0, 0, 1,  .25, .25,	_c, 1);
					
								vertex_add_point(global.lev_buff, _xB,	_yB,  0,  0, 0, 1,  .25, .25,	_c, 1);
								vertex_add_point(global.lev_buff, _xA,	_yB,  0,  0, 0, 1,  0,   .25,	_c, 1);
								vertex_add_point(global.lev_buff, _xA,	_yA,  0,  0, 0, 1,  0,   0,		_c, 1);
				
								if (i > 0 && i < GRID_H - 1 && _plan[i - 1][j] > 1)
								{
									// n
									vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,  .25,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yA, _d,  0, 0, 1,   .5,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yA,  0,  0, 0, 1,   .5, .25,	_c, 1);
					
									vertex_add_point(global.lev_buff, _xB,	_yA,  0,  0, 0, 1,   .5, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yA,  0,  0, 0, 1,  .25, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,  .25,   0,	_c, 1);
								}
								if (j > 0 && j < GRID_W - 1 && _plan[i][j - 1] > 1)
								{
									// w
									vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,   .5,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yB, _d,  0, 0, 1,  .75,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yB,  0,  0, 0, 1,  .75, .25,	_c, 1);
					
									vertex_add_point(global.lev_buff, _xA,	_yB,  0,  0, 0, 1,  .75, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yA,  0,  0, 0, 1,   .5, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yA, _d,  0, 0, 1,   .5,   0,	_c, 1);
								}
								if (i > 0 && i < GRID_H - 1 && _plan[i + 1][j] > 1)
								{
									// s
									vertex_add_point(global.lev_buff, _xA,	_yB, _d,  0, 0, 1,  .75,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yB, _d,  0, 0, 1,    1,   0,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yB,  0,  0, 0, 1,    1, .25,	_c, 1);
					
									vertex_add_point(global.lev_buff, _xB,	_yB,  0,  0, 0, 1,    1, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yB,  0,  0, 0, 1,  .75, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xA,	_yB, _d,  0, 0, 1,  .75,   0,	_c, 1);
								}
								if (j > 0 && j < GRID_W - 1 && _plan[i][j + 1] > 1)
								{
									// e
									vertex_add_point(global.lev_buff, _xB,  _yA, _d,  0, 0, 1,    0, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yB, _d,  0, 0, 1,  .25, .25,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yB,  0,  0, 0, 1,  .25,  .5,	_c, 1);
					
									vertex_add_point(global.lev_buff, _xB,  _yB,  0,  0, 0, 1,  .25,  .5,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yA,  0,  0, 0, 1,    0,  .5,	_c, 1);
									vertex_add_point(global.lev_buff, _xB,  _yA, _d,  0, 0, 1,    0, .25,	_c, 1);
								}
							}
						}
					}
	
					_plan = 0;
				}
			
				/// @function			clear_room(_x, _y)
				/// @description		Initialize room back to blank state.
				/// @param	{real}	_x	Horizontal coordinate.
				/// @param	{real}	_y	Vertical coordinate.
				function clear_room(_x, _y)
				{
					coord_x = _x;
					coord_y = _y;
					doors = exits.blank;
					stairs = exits.blank;
					live = false; // true if cell is currently active
					threat = true;
					obstacles = irandom_range(0, 4);
					enemies = irandom_range(0, 4);
				}
			#endregion
		}
		
		/* Begin Floor Initialization */
			lev_w = _width;
			lev_h = _height;
			lev_w2 = lev_w * 2 - 1;
			lev_h2 = lev_h * 2 - 1;
			end_x = 0;
			end_y = 0;
			layout[lev_h2][lev_w2] = 0;
		
			for (var i = lev_h2; i >= 0; i--)
			{
				for (var j = lev_w2; j >= 0; j--)
				{
					layout[i][j] = new Room(j, i);
				}
			}
		/* End Floor Initialization */
		
		#region Floor Functions
			/// @function			build_floor(_x, _y)
			/// @description		Write currently playable portion of floor into vertex buffer.
			/// @param	{real}	_x	Horizontal coordinate.
			/// @param	{real}	_y	Vertical coordinate.
			function build_floor(_x, _y)
			{
				instance_destroy(obj_enem01);
				instance_destroy(obj_stairs);
				instance_destroy(obj_treasure);
				instance_destroy(obj_health);
				vertex_begin(global.lev_buff, vertex_format);
			
				// Main
					var _tmp = layout[_y][_x];
					_tmp.live = true;
					_tmp.build_room(GRID_W * 1, GRID_H * 1 + 2);
				// North
					if (_y - 1 >= 0 && layout[_y - 1][_x].doors != exits.blank)
					{
						_tmp = layout[_y - 1][_x];
						_tmp.live = false;
						_tmp.build_room(GRID_W * 1, 0 + 2);
					}
				// West
					if (_x - 1 >= 0 && layout[_y][_x - 1].doors != exits.blank)
					{
						_tmp = layout[_y][_x - 1];
						_tmp.live = false;
						_tmp.build_room(0, GRID_H * 1 + 2);
					}
				// South
					if (_y + 1 < lev_h && layout[_y + 1][_x].doors != exits.blank)
					{
						_tmp = layout[_y + 1][_x];
						_tmp.live = false;
						_tmp.build_room(GRID_W * 1, GRID_H * 2 + 2);
					}
				// East
					if (_x + 1 < lev_w && layout[_y][_x + 1].doors != exits.blank)
					{
						_tmp = layout[_y][_x + 1];
						_tmp.live = false;
						_tmp.build_room(GRID_W * 2, GRID_H * 1 + 2);
					}
				vertex_end(global.lev_buff);
			}
		
			/// @function		clear_floor()
			/// @description	Clears existing floor data.
			function clear_floor()
			{
				for (var i = lev_h2; i >= 0; i--)
				{
					for (var j = lev_w2; j >= 0; j--)
					{
						layout[i][j].clear_room(j, i);
					}
				}
			}
		
			/// @function		draw_floor()
			/// @description	Draw 2D representation of floor. (TODO)
			function draw_floor()
			{
				// TODO
			}
		
			/// @function				define_floor(_startX, _startY)
			/// @description			Defines room exit data for entire floor with bitmasking.
			/// @param	{real}	_startX	Horizontal starting coordinate.
			/// @param	{real}	_startY	Vertical starting coordinate.
			function define_floor(_startX, _startY)
			{
				layout[_startY][_startX].stairs = exits.DOWN;
				layout[_startY][_startX].obstacles = 0;
				var _exit = ds_list_create();
				for (var i = 0; i < lev_h2; i++)
				{
					for (var j = 0; j < lev_w2; j++)
					{
						if (layout[i][j].doors == exits.PEND)
						{
							layout[i][j].doors = 0x00;
							//North
								if (i - 1 >= 0 && layout[i - 1][j].doors != exits.blank)
								{
									layout[i][j].doors += 0x01;
								}
							//West
								if (j - 1 >= 0 && layout[i][j - 1].doors != exits.blank)
								{
									layout[i][j].doors += 0x02;
								}
							//South
								if ((i + 1 < lev_h2) && layout[i + 1][j].doors != exits.blank)
								{
									layout[i][j].doors += 0x04;
								}
							//East
								if ((j + 1 < lev_w2) && layout[i][j + 1].doors != exits.blank)
								{
									layout[i][j].doors += 0x08;
								}
							// Make Dead Ends more special-er
							switch (layout[i][j].doors)
							{
								case 0x01:	// N
									if (layout[i][j].stairs != exits.DOWN)
									{
										ds_list_add(_exit, layout[i][j]);
									}
									break;
								case 0x02:	// W
									if (layout[i][j].stairs != exits.DOWN)
									{
										ds_list_add(_exit, layout[i][j]);
									}
									break;
								case 0x04:	// S
									if (layout[i][j].stairs != exits.DOWN)
									{
										ds_list_add(_exit, layout[i][j]);
									}
									break;
								case 0x08:	// E
									if (layout[i][j].stairs != exits.DOWN)
									{
										ds_list_add(_exit, layout[i][j]);
									}
									break;
								default:
									break;
							}
						}
					}
				}
				ds_list_shuffle(_exit);
				_exit[| 0].stairs = exits.UP;
				_exit[| 0].obstacles = 0;
				for (var i = 1; i < ds_list_size(_exit); i++)
				{
					if (i % 2 == 1)
					{
						_exit[| i].stairs = exits.TREASURE;
					}
					else
					{
						_exit[| i].stairs = exits.MIDBOSS;
					}
					_exit[| i].obstacles = 0;
				}
				end_x = _exit[| 0].coord_x;
				end_y = _exit[| 0].coord_y;
				ds_list_destroy(_exit);
			
				reduce_floor();
			}
		
			/// @function			generate_floor(_x, _y)
			/// @description		Generates new floor data via a recursive backtracking algorithm.
			/// @param	{real}	_x	Horizontal coordinate.
			/// @param	{real}	_y	Vertical coordinate.
			function generate_floor(_x, _y)
			{
				if (layout[_y][_x].doors == exits.blank)
				{
					layout[_y][_x].doors = exits.PEND;
				}
				else
				{
					return;
				}
				var _dir = ds_list_create();
				ds_list_add(_dir, 0, 1, 2, 3);
				ds_list_shuffle(_dir);
				for (var i = 0; i < 4; i++)
				{
					var _dirX = 0;
					var _dirY = 0;
					switch(_dir[| i])
					{
						case 0:
							_dirX = 1;
							break;
						case 1:
							_dirX = -1;
							break;
						case 2:
							_dirY = 1;
							break;
						case 3:
							_dirY = -1;
							break;
						default:
							break; 
					}
					var _x2 = _x + _dirX * 2;
					var _y2 = _y + _dirY * 2;
					if ((_x2 >= 0 && _x2 < lev_w2) && (_y2 >= 0 && _y2 < lev_h2))
					{
						if (layout[_y2][_x2].doors == exits.blank)
						{
							layout[_y2 - _dirY][_x2 - _dirX].doors = exits.PEND;
							generate_floor(_x2, _y2);
						}
					}
				}
				ds_list_destroy(_dir);
				return;
			}
		
			/// @function		reduce_floor()
			/// @description	Consolidate floor data.
			function reduce_floor()
			{
				for (var i = 0; i < lev_h; i++)
				{
					for (var j = 0; j < lev_w; j++)
					{
						layout[i][j].doors = layout[i * 2][j * 2].doors;
						layout[i][j].stairs = layout[i * 2][j * 2].stairs;
					}
				}
			}
		
			/// @function				reset_floor(_startX, _startY)
			/// @description			Clears existing floor data,
			///							generates new floor data,
			///							and defines room type data for entire floor.
			/// @param	{real}	_startX	Horizontal starting coordinate.
			/// @param	{real}	_startY	Vertical starting coordinate.
			function reset_floor(_startX, _startY)
			{
				clear_floor();
				generate_floor(_startX, _startY);
				define_floor(_startX, _startY);
			}
		#endregion
	}
	
	/* Begin Level Initialization */
		lev_w = _width;
		lev_h = _height;
		lev_z = _floors;
		level[lev_z] = 0;
		cursorX = 0;
		cursorY = 0;
		cursorZ = 0;
	
		for (var i = lev_z; i >= 0; i--)
		{
			level[i] = new Floor(lev_w, lev_h);
		}
	/* End Level Initialization */
	
	#region Level Functions
		/// @function			build_level(_x, _y, _z)
		/// @description		Write currently playable portion of level into vertex buffer.
		/// @param	{real}	_x	Horizontal coordinate.
		/// @param	{real}	_y	Vertical coordinate.
		/// @param	{real}	_z	Depth coordinate.
		function build_level(_x, _y, _z)
		{
			if (cursorX + _x >= 0 && cursorX + _x <= lev_w)
			{
				if (level[cursorZ].layout[cursorY][cursorX + _x].doors != exits.blank)
				{
					cursorX += _x;
				}
			}
			if (cursorY + _y >= 0 && cursorY+ _y <= lev_h)
			{
				if (level[cursorZ].layout[cursorY + _y][cursorX].doors != exits.blank)
				{
					cursorY += _y;
				}
			}
			if (cursorZ + _z >= 0 && cursorZ + _z <= lev_z)
			{
				if (_z == 1 && level[cursorZ].layout[cursorY][cursorX].stairs == exits.UP)
				{
					cursorZ += _z;
				}
				else if (_z == -1 && level[cursorZ].layout[cursorY][cursorX].stairs == exits.DOWN)
				{
					cursorZ += _z;
				}
			}
			level[cursorZ].build_floor(cursorX, cursorY);
		}
	
		/// @function		clear_level()
		/// @description	Clears existing level data.
		function clear_level()
		{
			for (var i = 0; i < lev_z; i++)
			{
				level[lev_z].clear_floor();
			}
		}
	
		/// @function				draw_level(_floor)
		/// @description			Draws a 2D representation of current floor.
		/// @param	{real}	_floor	Depth coordinate.
		function draw_level(_floor)
		{
			level[_floor].draw_floor();
		}
	
		/// @function		generate_level()
		/// @description	Genarates new level data.
		function generate_level()
		{
			level[0].reset_floor(0, 0);
			if (lev_z > 0)
			{
				for (var i = 1; i < lev_z; i++)
				{
					level[i].reset_floor(level[i - 1].end_x, level[i - 1].end_y);
				}
			}
		}
	
		/// @function		reset_level()
		/// @description	Initializes cursor variables, 
		///					clears existing level data, 
		///					and generates new level data.
		function reset_level()
		{
			cursorX = 0;
			cursorY = 0;
			cursorZ = 0;
			clear_level();
			generate_level();
		}
	#endregion
}


/// @function				floor_plan(_plan, _obst)
/// @description			Returns Room layout as a 2D array.
/// @param	{real}	_plan	Door Layout value.
/// @param	{real}	_obst	Obstacle layout value.
function floor_plan(_plan, _obst)
{
	var _h = GRID_H - 1;
	var _w = GRID_W - 1;
	var _h2 = floor(GRID_H / 2);
	var _w2 = floor(GRID_W / 2);
	
	var temp = 0;
	temp[_h] = 0;
	for (var i = _h; i >= 0; i--)
	{
		for (var j = _w; j >= 0; j--)
		{
			if (i == 0 || i == _h || j == 0 || j == _w)
			{
				temp[i][j] = 2;
			}
			else
			{
				temp[i][j] = 0;
			}
		}
	}
	#region Doorways
		// North
			if (_plan == 1 || _plan == 3 || _plan == 5 || _plan == 7 || _plan == 9 || _plan == 11 || _plan == 13 || _plan == 15)
			{
				temp[0][_w2 - 1]  = 0;
				temp[0][_w2] = 0;
			}
		// West
			if (_plan == 2 || _plan == 3 || _plan == 6 || _plan == 7 || _plan == 10 || _plan == 11 || _plan == 14 || _plan == 15)
			{
				temp[_h2 - 1][0] = 0;
				temp[_h2][0] = 0;
			}
		// South
			if (_plan == 4 || _plan == 5 || _plan == 6 || _plan == 7 || _plan == 12 || _plan == 13 || _plan == 14 || _plan == 15)
			{
				temp[_h][_w2 - 1]  = 0;
				temp[_h][_w2] = 0;
			}
		// East
			if (_plan == 8 || _plan == 9 || _plan == 10 || _plan == 11 || _plan == 12 || _plan == 13 || _plan == 14 || _plan == 15)
			{
				temp[_h2 - 1][_w] = 0;
				temp[_h2][_w] = 0;
			}
	#endregion
	#region Populate Obstacles
		var _tmp = 0;
		switch(_obst)
		{
			case 0:
				_tmp[0] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[1] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[2] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[3] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[4] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[5] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[6] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[7] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[9] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				break;
			case 1:
				_tmp[0] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[1] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[2] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[3] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[4] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[5] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[6] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[7] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[8] = [0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00];
				_tmp[9] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				break;
			case 2:
				_tmp[0] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[1] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[2] = [0x00, 0x00, 0x02, 0x01, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x01, 0x02, 0x00, 0x00];
				_tmp[3] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[4] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[5] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[6] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[7] = [0x00, 0x00, 0x02, 0x01, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x01, 0x02, 0x00, 0x00];
				_tmp[8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[9] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				break;
			case 3:
				_tmp[0] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[1] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[2] = [0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00];
				_tmp[3] = [0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00];
				_tmp[4] = [0x00, 0x00, 0x02, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x02, 0x00, 0x00];
				_tmp[5] = [0x00, 0x00, 0x02, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x02, 0x00, 0x00];
				_tmp[6] = [0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x00];
				_tmp[7] = [0x00, 0x00, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x02, 0x00, 0x00];
				_tmp[8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[9] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				break;
			case 4:
				_tmp[0] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[1] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[2] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[3] = [0x00, 0x00, 0x00, 0x02, 0x01, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x01, 0x02, 0x00, 0x00, 0x00];
				_tmp[4] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[5] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[6] = [0x00, 0x00, 0x00, 0x02, 0x01, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x01, 0x02, 0x00, 0x00, 0x00];
				_tmp[7] = [0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x02, 0x00, 0x02, 0x00, 0x02, 0x00, 0x00, 0x00];
				_tmp[8] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				_tmp[9] = [0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00];
				break;
			default:
				break;
		}
		for (var i = 0; i < GRID_H; i++)
		{
			for (var j = 0; j < GRID_W; j++)
			{
				if (i <= array_length(_tmp) - 1 && j <= array_length(_tmp[i]) - 1)
				{
					if (_tmp[i][j] > temp[i][j])
					{
						temp[i][j] = _tmp[i][j];
					}
				}
			}
		}
		_tmp = 0;
	#endregion
	return temp;
}