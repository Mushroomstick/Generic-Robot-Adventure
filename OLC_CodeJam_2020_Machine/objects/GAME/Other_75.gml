/// @description GAME: Async System Event

#region Gamepad Detection and Stuff
	show_debug_message("Event = " + async_load[? "event_type"]);      // Debug code so you can see which event has been
	show_debug_message("Pad = " + string(async_load[? "pad_index"])); // triggered and the pad associated with it.

	switch(async_load[? "event_type"])  // Parse the async_load map to see which event has been triggered
	{
	   case "gamepad discovered":                   // A game pad has been discovered
	      var _pad = async_load[? "pad_index"];     // Get the pad index value from the async_load map
	      gamepad_set_axis_deadzone(_pad, 0.5);     // Set the "deadzone" for the axis
	      gamepad_set_button_threshold(_pad, 0.1);  // Set the "threshold" for the triggers
	      if (pad == noone) // Check to see if an instance is associated with this pad index
	      {
	         pad = _pad;
	      }
	      break;
	   case "gamepad lost":                      // Gamepad has been removed or otherwise disabled
	      var _pad = async_load[? "pad_index"];  // Get the pad index
	      if (_pad == pad)
	      {
	         pad = noone;   // Set pad value to "noone" so it detects a new pad being connected
	      }
	      break;
	   default:
	      break;
	}
#endregion