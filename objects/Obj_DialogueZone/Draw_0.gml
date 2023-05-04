draw_set_alpha(.6 * alpha);
draw_rectangle_color(
		x_center - back_rect_offset,
		y_center - back_rect_offset,
		x_center + back_rect_offset,
		y_center + back_rect_offset,
		c_black, c_black, c_black, c_black, false);
draw_set_alpha(1 * alpha);

draw_self();

var swirl_off = sprite_width / 2 + 5;
var swirl_max = swirl_off * 2 - 2;

var swirlval1 = swirl_counter;
var swirlval2 = (swirl_counter + .2) % 1;

draw_set_alpha(.8 * alpha);

if ((swirlval1 >= 0 && swirlval1 <= .25)
		|| (swirlval2 >= 0 && swirlval2 <= .25))
{
	var tmp1 = swirlval1 > .5 ? swirlval1 - 1 : swirlval1;
	var tmp2 = swirlval2 > .5 ? swirlval2 - 1 : swirlval2;
	var val1 = clamp(tmp1, 0, .25) * swirl_max * 4;
	var val2 = clamp(tmp2, 0, .25) * swirl_max * 4;
	draw_line_width_color(
			x_center - swirl_off + val1,
			y_center - swirl_off,
			x_center - swirl_off + val2,
			y_center - swirl_off,
			2, c_aqua, c_aqua);
}

if ((swirlval1 >= .5 && swirlval1 <= .75)
		|| (swirlval2 >= .5 && swirlval2 <= .75))
{
	var val1 = clamp(swirlval1 - .5, 0, .25) * swirl_max * 4;
	var val2 = clamp(swirlval2 - .5, 0, .25) * swirl_max * 4;
	draw_line_width_color(
			x_center - swirl_off + swirl_max - val2, 
			y_center - swirl_off + swirl_max,
			x_center - swirl_off + swirl_max - val1, 
			y_center - swirl_off + swirl_max,
			2, c_aqua, c_aqua);
}

if ((swirlval1 >= .75 && swirlval1 <= 1)
		|| (swirlval2 >= .75 && swirlval2 <= 1))
{
	var tmp1 = swirlval1 < .25 ? swirlval1 + 1 : swirlval1;
	var tmp2 = swirlval2 < .25 ? swirlval2 + 1 : swirlval2;
	var val1 = clamp(tmp1 - .75, 0, .25) * swirl_max * 4;
	var val2 = clamp(tmp2 - .75, 0, .25) * swirl_max * 4;
	draw_line_width_color(
			x_center - swirl_off, 
			y_center - swirl_off + swirl_max - val2,
			x_center - swirl_off, 
			y_center - swirl_off + swirl_max - val1,
			2, c_aqua, c_aqua);
}

if ((swirlval1 >= .25 && swirlval1 <= .5)
		|| (swirlval2 >= .25 && swirlval2 <= .5))
{
	var val1 = clamp(swirlval1 - .25, 0, .25) * swirl_max * 4;
	var val2 = clamp(swirlval2 - .25, 0, .25) * swirl_max * 4;
	draw_line_width_color(
			x_center - swirl_off + swirl_max, 
			y_center - swirl_off + val1,
			x_center - swirl_off + swirl_max, 
			y_center - swirl_off + val2,
			2, c_aqua, c_aqua);
}

draw_set_alpha(1);

if (GetMode() == Modes.DIE)
{
	draw_set_alpha(deathalpha);
	draw_rectangle_color(
		camera_get_view_x(view_camera[0]),
		camera_get_view_y(view_camera[0]),
		camera_get_view_x(view_camera[0]) + view_wport[0],
		camera_get_view_y(view_camera[0]) + view_hport[0],
		c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}