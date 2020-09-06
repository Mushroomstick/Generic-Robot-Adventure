#macro TILE_W 32
#macro TILE_H 32
#macro TILE_D -32


/*	Initialize Global Vertex Format	*/
	vertex_format_begin();
	vertex_format_add_position_3d();
	vertex_format_add_normal();
	vertex_format_add_texcoord();
	vertex_format_add_color();
	global.vert_format = vertex_format_end();
	#macro vertex_format global.vert_format

/*	Initialize Global Vertex Buffer to write Level data to	*/
	global.lev_buff = vertex_create_buffer();
	vertex_begin(global.lev_buff, vertex_format);
	vertex_end(global.lev_buff)

/// @function				vertex_add_point(_vbuff, _x, _y, _z, _nx, _ny, _nz, _utex, _vtex, _color, _alpha)
/// @description			Adds a vertex to a vertex buffer.
/// @param	{id}	_vbuff	Vertex buffer id.
/// @param	{real}	_x		Vertex x coordinate.
/// @param	{real}	_y		Vertex y coordinate.
/// @param	{real}	_z		Vertex z coordinate.
/// @param	{real}	_nx		Normal map x coordinate.
/// @param	{real}	_ny		Normal map y coordinate.
/// @param	{real}	_nz		Normal map z coordinate.
/// @param	{real}	_utex	X texture coordinate.
/// @param	{real}	_vtex	Y texture coordinate.
/// @param	{real}	_color	Color value (constant or hex value).
/// @param	{real}	_alpha	Alpha value.
function vertex_add_point(_vbuff, _x, _y, _z, _nx, _ny, _nz, _utex, _vtex, _color, _alpha)
{
   vertex_position_3d(_vbuff, _x, _y, _z);
   vertex_normal(_vbuff, _nx, _ny, _nz);
   vertex_texcoord(_vbuff, _utex, _vtex);
   vertex_color(_vbuff, _color, _alpha);
}