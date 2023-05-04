col_counter++;
if (col_counter >= 1)
{
	col_counter = 0;
	curr_col = curr_col == c_fuchsia ? c_white : c_fuchsia;
}

image_blend = curr_col;

if (GetMode() == Modes.PLAY)
{
	image_alpha = lerp(image_alpha, .2, .03);
}

if (GetMode() == Modes.START)
{
	if (back_rect_offset <= 5)
	{
		SetMode(Modes.PLAY);
		audio_play_sound(Sfx_Start, 10, false);
	}
	camera_set_view_pos(view_camera[0], 
			lerp(camera_get_view_x(view_camera[0]), x_center - view_wport[0] / 2, 0.07), 
			lerp(camera_get_view_y(view_camera[0]), y_center - view_hport[0] / 2, 0.07));
}

if (GetMode() == Modes.END || GetMode() == Modes.DIE)
{
	alpha = lerp(alpha, 0, .1);
	image_alpha = lerp(image_alpha, 0, .1);
}

if (GetMode() == Modes.DIE)
{
	deathalpha = lerp(deathalpha, .6, .06);
}

swirl_spd = lerp(swirl_spd, .03, .03);
swirl_counter = (swirl_counter + swirl_spd) % 1;
back_rect_offset = lerp(back_rect_offset, 0, .04);