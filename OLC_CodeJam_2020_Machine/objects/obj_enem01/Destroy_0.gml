/// @description obj_enem01: Destroy Event

#region Create obj_stairs, if necessary
	if (GAME.test.level[GAME.test.cursorZ].layout[GAME.test.cursorY][GAME.test.cursorX].stairs = exits.UP)
	{
		instance_create_layer(1920 / 2, 1080 / 2, "Instances", obj_stairs);
	}
#endregion

#region Destroy Vertex Buffer
	vertex_delete_buffer(pbuffer);
#endregion