flicker_counter++;
if (flicker_counter >= 6)
	flicker_counter = 0;

if (((GetMode() == Modes.START || GetMode() == Modes.END) && flicker_counter < 3)
		|| GetMode() == Modes.PLAY || GetMode() == Modes.DIE)
	draw_self();

if (GetMode() == Modes.PLAY)
{
	core_col_timer = (core_col_timer + 1) % 2;
	if (core_col_timer == 0)
		core_color = (core_color == c_red) ? c_yellow : c_red;
	draw_circle_color(x, y, 3, core_color, core_color, false);
	draw_circle_color(x, y, 3.5, c_black, c_black, true);
}