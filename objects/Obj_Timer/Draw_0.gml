draw_set_alpha(alpha * 0.6);
draw_circle_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		30,
		c_black,
		c_black,
		false);
draw_set_alpha(alpha);
draw_circle_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		30,
		c_white,
		c_white,
		true);
draw_circle_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		29,
		c_white,
		c_white,
		true);
var angle = global.countdown * 2 * pi / 10;
draw_line_width_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40 - 30,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		3,
		c_aqua, c_aqua)
draw_line_width_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40,
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40,
		camera_get_view_x(view_camera[0]) + view_wport[0] - 40 - 30 * cos(angle),
		camera_get_view_y(view_camera[0]) + view_hport[0] - 40 - 30 * sin(angle),
		3,
		c_red, c_red)
draw_set_alpha(1);