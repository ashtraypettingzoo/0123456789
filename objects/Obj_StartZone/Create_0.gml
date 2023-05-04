curr_col = c_fuchsia;
col_counter = 0;
SetMode(Modes.START);
image_alpha = 1;

x_center = x + sprite_width / 2;
y_center = y + sprite_height / 2;
var y_bottom = y + sprite_height;

if (!instance_exists(Obj_Player))
{
	inst = instance_create_depth(0, 0, depth - 100, Obj_Player);
	inst.x = x_center;
	var y_off = inst.bbox_bottom - inst.y;
	inst.y = y_bottom - y_off;
}

swirl_counter = 0;
swirl_spd = .45;
back_rect_offset = 2000;

if (!variable_global_exists("just_died"))
{
	global.just_died = true;
}

if (global.just_died)
	camera_set_view_pos(view_camera[0], -1000, -1000);
else
	camera_set_view_pos(view_camera[0],
			x_center - (view_wport[0] / 2),
			y_center - (view_hport[0] / 2));

alpha = 1;
deathalpha = 0;

audio_play_sound(Sfx_Load, 10, false);