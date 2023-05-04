col_counter++;
if (col_counter >= 1)
{
	col_counter = 0;
	curr_col = curr_col == c_fuchsia ? c_white : c_fuchsia;
}

image_blend = curr_col;


swirl_counter = (swirl_counter + swirl_spd) % 1;