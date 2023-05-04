curr_color = (curr_color == c_yellow) ? c_fuchsia : c_yellow;

for (var i = 0; i < num_spokes; i++)
{
	var theta = curr_theta + 2 * pi * i / num_spokes;
	draw_line_width_color(x, y, x + radius * cos(theta), y + radius * sin(theta), 4, curr_color, curr_color);
}