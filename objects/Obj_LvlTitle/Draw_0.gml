draw_set_alpha(alpha * 0.7);

draw_rectangle_color(
		camera_get_view_x(view_camera[0]) + x_left,
		camera_get_view_y(view_camera[0]) + view_hport[0] / 2 - 20,
		camera_get_view_x(view_camera[0]) + x_right,
		camera_get_view_y(view_camera[0]) + view_hport[0] / 2 + 20,
		c_black, c_black, c_black, c_black, false);

draw_set_alpha(alpha);
draw_set_font(Fnt_Tag);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
var col = make_color_hsv(hue_ctr * 255, 200, 200);
draw_text_color(
		camera_get_view_x(view_camera[0]) + view_wport[0] / 2 + 5,
		camera_get_view_y(view_camera[0]) + view_hport[0] / 2 + 5,
		global.room_title,
		col, col, col, col, alpha);
draw_text(
		camera_get_view_x(view_camera[0]) + view_wport[0] / 2,
		camera_get_view_y(view_camera[0]) + view_hport[0] / 2,
		global.room_title);
		
draw_set_alpha(1.);