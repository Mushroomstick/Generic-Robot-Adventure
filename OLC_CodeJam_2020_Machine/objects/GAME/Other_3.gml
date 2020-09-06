/// @description GAME: Game End Event

#region Hopefully, destroy anything that might cause a memory leak
	font_delete(global.fnt_dmg);
	font_delete(global.fnt_lite);
	ds_queue_destroy(fpsQueue);
	vertex_delete_buffer(global.lev_buff);
	vertex_format_delete(vertex_format);
#endregion