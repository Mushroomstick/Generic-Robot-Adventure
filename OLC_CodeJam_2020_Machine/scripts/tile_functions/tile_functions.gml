/// @description tile collision functions

/// @function                 tile_meeting(_x, _y, _tilemap);
/// @param  {real}  _x        The horizontal position
/// @param  {real}  _y        The vertical position
/// @param  {id}    _tilemap  The tilemap id
function tile_meeting(_x, _y, _tilemap)
{
	var _xOrigin = x;
	var _yOrigin = y;

	x = _x;
	y = _y;

	var _meet = tilemap_get_at_pixel(_tilemap, bbox_right, bbox_top)	   ||
				   tilemap_get_at_pixel(_tilemap, bbox_right, bbox_bottom)  ||
				   tilemap_get_at_pixel(_tilemap, bbox_left,  bbox_top)	   ||
				   tilemap_get_at_pixel(_tilemap, bbox_left,  bbox_bottom);

	x = _xOrigin;
	y = _yOrigin;

	return(_meet);
}

/// @function                 tile_collision_line(_x1, _y1, _x2, _y2, _tilemap);
/// @param  {real}  _x1       Horizontal position 1
/// @param  {real}  _y1       Vertical position 1
/// @param  {real}  _x2       Horizontal position 2
/// @param  {real}  _y2       Vertical position 2
/// @param  {id}    _tilemap  The tilemap id
function tile_collision_line(_x1, _y1, _x2, _y2, _tilemap)
{
   var _dir = point_direction(_x1, _y1, _x2, _y2);
   var _dist = point_distance(_x1, _y1, _x2, _y2);
   
   for (var i = 0; i < _dist; i++)
   {
      var _x3 = lengthdir_x(i, _dir);
      var _y3 = lengthdir_y(i, _dir);
      if (tile_meeting(_x1 + _x3, _y1 + _y3, _tilemap))
      {
         return true;
      }
   }
   return false;
}