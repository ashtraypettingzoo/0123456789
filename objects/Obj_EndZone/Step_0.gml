col_counter++;
if (col_counter >= 1)
{
	col_counter = 0;
	curr_col = curr_col == c_fuchsia ? c_white : c_fuchsia;
}

image_blend = curr_col;

if (GetMode() == Modes.END)
{
	camera_set_view_pos(view_camera[0], 
			lerp(camera_get_view_x(view_camera[0]), x_center - view_wport[0] / 2, 0.07), 
			lerp(camera_get_view_y(view_camera[0]), y_center - view_hport[0] / 2, 0.07));
	back_rect_offset = lerp(back_rect_offset, 2000, .03);
	image_alpha = lerp(image_alpha, 1, .02);
	swirl_spd = lerp(swirl_spd, .45, .01);
	
	if (image_alpha >= .75 && !soundplayed)
	{
		audio_play_sound(Sfx_Unload, 10, false);
		soundplayed = true;
	}
	
	if (image_alpha >= .95)
		GoToNextRoom();
}

if (GetMode() == Modes.DIE)
{
	alpha = lerp(alpha, 0, .1);
	image_alpha = lerp(image_alpha, 0, .1);
}


swirl_counter = (swirl_counter + swirl_spd) % 1;
back_rect_offset = lerp(back_rect_offset, 0, .04);