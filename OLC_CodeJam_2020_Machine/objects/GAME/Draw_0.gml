/// @description GAME: Draw Event

#region Setup Camera
	if (instance_exists(obj_player))
	{
		x = obj_player.x;
		y = obj_player.y;
	}
	var camera = camera_get_active();
	camera_set_view_mat(camera, matrix_build_lookat(x + offx, y + offy, -z, x, y, -8, dcos(dir), -dsin(dir), 0));
	camera_set_proj_mat(camera, matrix_build_projection_perspective_fov(35, window_get_width() / window_get_height(), 1, 32000));
	camera_apply(camera);
#endregion

#region Draw Level
	vertex_submit(global.lev_buff, pr_trianglelist, sprite_get_texture(spr_testCube, 0));
#endregion