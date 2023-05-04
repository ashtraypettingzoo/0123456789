shader_set(Shdr_Lava);
var uni_time = shader_get_uniform(Shdr_Lava, "u_time");
var uni_resw = shader_get_uniform(Shdr_Lava, "u_resw");
var uni_resh = shader_get_uniform(Shdr_Lava, "u_resh");
var uni_camx = shader_get_uniform(Shdr_Lava, "u_camx");
var uni_camy = shader_get_uniform(Shdr_Lava, "u_camy");
shader_set_uniform_f(uni_time, current_time);
shader_set_uniform_f(uni_resw, view_wport[0]);
shader_set_uniform_f(uni_resh, view_hport[0]);
shader_set_uniform_f(uni_camx, camera_get_view_x(view_camera[0]));
shader_set_uniform_f(uni_camy, camera_get_view_y(view_camera[0]));
draw_rectangle(x, y - 5 + (5 * sin(wobblectr)), x + 2000, y + 1000, false);
shader_reset();

for (var i = 0; i < 12; i++)
{
	var hue1 = (huectr + (i * .07)) % 1;
	var hue2 = (huectr + ((i+1) * .07)) % 1;
	var col1 = make_color_hsv(hue1 * 255, 255, 255);
	var col2 = make_color_hsv(hue2 * 255, 255, 255);
	var val1 = linectr1 + (i+1) * 0.45;
	var val2 = linectr2 + (i+1) * 0.51;
	var prevval1 = linectr1 + i * 0.45;
	var prevval2 = linectr2 + i * 0.51;
	var val = (sin(val1) + sin(val2)) /2;
	var prevval = (sin(prevval1) + sin(prevval2)) /2;
	draw_line_width_color(
			camera_get_view_x(view_camera[0]) + view_wport[0] * (i / 12),
			y - 5 + (5 * sin(wobblectr)) + 7 * prevval,
			camera_get_view_x(view_camera[0]) + view_wport[0] * ((i+1) / 12),
			y - 5 + (5 * sin(wobblectr)) + 7 * val,
			5, col1, col2);
}