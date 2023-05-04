var JUMP_SPD = 570;
var DOUBLE_JUMP_SPD = 540;
var WALL_JUMP_VSPD = 540;
var WALL_JUMP_HSPD = 740;
var GRAV_HI = 2100;
var GRAV_LO = 1100;
var GRAV_THRESH = 100;
var JUMP_RELEASE = 0.45;
var FALL_THRESH = 450;
var FALL_MAX = 1800;
var ACCEL_AIR = 7000;
var ACCEL_LO = 200;
var ACCEL_HI = 11000;
var ACCEL_THRESH = 380;
var ACCEL_MAX = 2400;
var FRIC_GRND = 10000;
var FRIC_AIR = 4000;
var SLIDE_THRESH = 700;
var FRIC_SLIDE = 1000;
var INCLINE_ACC = 1500;
var INCLINE_MAX = 260;
var FRIC_SLIDE_UP = 3400;
var SLOW_THRESH = 200;
var SLOW_ACC = 2000;
var MAX_DELTA = 4.0 / 60.0;
var WALL_STICK = .11;

enum Inputs
{
	LEFT,
	RIGHT,
	JUMP,
	SLOW,
	RESTART
}

function input_check(input, deadzone = 0.3) {
	var res = false;
	switch (input)
	{
	case Inputs.LEFT:
		res = (gamepad_is_connected(0) && gamepad_axis_value(0, gp_axislh) <= -deadzone)
				|| keyboard_check(vk_left);
		break;
	case Inputs.RIGHT:
		res = (gamepad_is_connected(0) && gamepad_axis_value(0, gp_axislh) >= deadzone)
				|| keyboard_check(vk_right);
		break;
	case Inputs.JUMP:
		res = (gamepad_is_connected(0) && gamepad_button_check(0, gp_face1))
				|| keyboard_check(vk_up)
				|| keyboard_check(ord("Z"));
		break;
	case Inputs.RESTART:
		res = (gamepad_is_connected(0) && gamepad_button_check(0, gp_face4))
				|| keyboard_check(ord("R"));
		break;
	case Inputs.SLOW:
		res = (gamepad_is_connected(0) && gamepad_button_check(0, gp_shoulderlb))
				|| keyboard_check(vk_shift);
	}
	return res;
}

function input_check_pressed(input, deadzone = 0.3) {
	var res = false;
	switch (input)
	{
	case Inputs.LEFT:
		res = (gamepad_is_connected(0) 
				&& gamepad_axis_value(0, gp_axislh) <= -deadzone && last_axislh > -deadzone)
				|| keyboard_check_pressed(vk_left);
		break;
	case Inputs.RIGHT:
		res = (gamepad_is_connected(0) 
				&& gamepad_axis_value(0, gp_axislh) >= deadzone && last_axislh < deadzone)
				|| keyboard_check_pressed(vk_right);
		break;
	case Inputs.JUMP:
		res = (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1))
				|| keyboard_check_pressed(vk_up)
				|| keyboard_check_pressed(ord("Z"));
		break;
	case Inputs.RESTART:
		res = (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face4))
				|| keyboard_check_pressed(ord("R"));
		break;
	case Inputs.SLOW:
		res = (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_shoulderlb))
				|| keyboard_check_pressed(vk_shift);
	}
	return res;
}

function input_check_released(input, deadzone = 0.3) {
	var res = false;
	switch (input)
	{
	case Inputs.LEFT:
		res = (gamepad_is_connected(0) 
				&& gamepad_axis_value(0, gp_axislh) > -deadzone && last_axislh <= -deadzone)
				|| keyboard_check_released(vk_left);
		break;
	case Inputs.RIGHT:
		res = (gamepad_is_connected(0) 
				&& gamepad_axis_value(0, gp_axislh) < deadzone && last_axislh >= deadzone)
				|| keyboard_check_released(vk_right);
		break;
	case Inputs.JUMP:
		res = (gamepad_is_connected(0) && gamepad_button_check_released(0, gp_face1))
				|| keyboard_check_released(vk_up)
				|| keyboard_check_released(ord("Z"));
		break;
	case Inputs.RESTART:
		res = (gamepad_is_connected(0) && gamepad_button_check_released(0, gp_face4))
				|| keyboard_check_released(ord("R"));
		break;
	case Inputs.SLOW:
		res = (gamepad_is_connected(0) && gamepad_button_check_released(0, gp_shoulderlb))
				|| keyboard_check_released(vk_shift);
	}
	return res;
}

function on_ground() {
	return is_colliding_at(0, 1) && !is_colliding_at(0, 0);
}

function on_right_wall() {
	return is_colliding_at(1, 0) && !is_colliding_at(0, 1) && !is_colliding_at(0, 0);
}

function on_left_wall() {
	return is_colliding_at(-1, 0) && !is_colliding_at(0, 1) && !is_colliding_at(0, 0);
}

function die() {
	global.just_died = true;
	hsp = random_range(-450, 450);
	vsp = random_range(-300, -150);
	rotvel = random_range(-20, 20);
	deathtimer = 105;
	SetMode(Modes.DIE);
	audio_play_sound(Sfx_Die, 10, false);
}

function is_colliding_at(dx, dy) {
	return instance_place(x + dx, y + dy, Obj_BlockMask) != noone;
}

function is_hazard_at(dx, dy, delta) {
	// check for spikes
	var retval = instance_place(x + dx, y + dy, Obj_SpikeMask) != noone;
	// check for spinners
	for (var i = 0; i < instance_count; i++)
	{
		var spinner = instance_find(Obj_LaserSpinner, i);
		if (spinner != noone)
			retval = retval || spinner.collides_with_player(x + dx, y + dy, delta);
	}
	// check 4 lavaaa
	retval = retval || (bbox_bottom >= instance_find(Obj_Lava, 0).y);
	return retval;
}

function process_movement(delta){
	var hsp_tmp = hsp * delta + hsp_part;
	var hsp_sign = sign(hsp_tmp);
	var hsp_whole = floor(abs(hsp_tmp));
	hsp_part = hsp_tmp - hsp_whole * hsp_sign;
	
	incline_dir = 0;
	for (i = 0; i < hsp_whole; ++i)
	{
		if (!is_colliding_at(hsp_sign, 0) || is_colliding_at(0, 0))
		{
			if (is_colliding_at(0, 1) && !is_colliding_at(hsp_sign, 1))
			{
				y += 1;
				decline_dir = hsp_sign;
			}
			x += hsp_sign;
			incline_dir = 0;
		}
		else if (!is_colliding_at(hsp_sign, -1))
		{
			x += hsp_sign;
			y -= 1;
			incline_dir = hsp_sign;
		}
		else
		{
			hsp = 0;
			hsp_part = 0;
			incline_dir = 0;
			break;
		}
		if (is_hazard_at(0, 0, delta))
			die();
	}
	
	var vsp_tmp = vsp * delta + vsp_part;
	var vsp_sign = sign(vsp_tmp);
	var vsp_whole = floor(abs(vsp_tmp));
	vsp_part = vsp_tmp - vsp_whole * vsp_sign;
	
	sliding_up_dir = 0;
	for (i = 0; i < vsp_whole; ++i)
	{
		if (!is_colliding_at(0, vsp_sign) || is_colliding_at(0, 0))
		{
			y += vsp_sign;
			sliding_up_dir = 0;
		}
		else if (vsp_sign == -1 && !is_colliding_at(-1, -1))
		{
			x -= 1;
			y -= 1;
			sliding_up_dir = -1;
		}
		else if (vsp_sign == -1 && !is_colliding_at(1, -1))
		{
			x += 1;
			y -= 1;
			sliding_up_dir = 1;
		}
		else
		{
			vsp = 0;
			vsp_part = 0;
			sliding_up_dir = 0;
			break;
		}
		if (is_hazard_at(0, 0, delta))
			die();
	}
}


var delta = delta_time / 1000000;
delta = min(delta, MAX_DELTA);
	
if (GetMode() == Modes.PLAY)
{
	if (input_check_pressed(Inputs.RESTART))
		die();
		
	// wall sticking
	if (!was_on_left_wall && on_left_wall())
	{
		audio_play_sound(Sfx_WallLand, 10, false);
		stuck_left = true;
		stick_ctr = WALL_STICK;
	}
	if (on_left_wall() && stuck_left)
	{
		if (input_check(Inputs.RIGHT))
		{
			stick_ctr -= delta;
			if (stick_ctr <= 0)
				stuck_left = false;
		}
		else
			stick_ctr = WALL_STICK;
	}
	else
		stuck_left = false;
		
	if (!was_on_right_wall && on_right_wall())
	{
		audio_play_sound(Sfx_WallLand, 10, false);
		stuck_right = true;
		stick_ctr = WALL_STICK;
	}
	if (on_right_wall() && stuck_right)
	{
		
		if (input_check(Inputs.LEFT))
		{
			stick_ctr -= delta;
			if (stick_ctr <= 0)
				stuck_right = false;
		}
		else
			stick_ctr = WALL_STICK;
	}
	else
		stuck_right = false;
	
	// left/right movement
	if (input_check(Inputs.LEFT) && hsp > -ACCEL_MAX && !stuck_right
			&& !(hsp < -SLOW_THRESH && input_check(Inputs.SLOW) && feat_enabled_slow))
	{
		if (hsp < -ACCEL_THRESH 
				|| ((sign(hsp) == incline_dir && on_ground()) && hsp < 0))
			hsp -= ACCEL_LO * delta;
		else if (on_ground())
			hsp -= ACCEL_HI * delta;
		else if (hsp > -ACCEL_THRESH)
			hsp -= ACCEL_AIR * delta;
		if (hsp < -SLOW_THRESH && input_check(Inputs.SLOW) && feat_enabled_slow)
			hsp = -SLOW_THRESH;
	}
	
	if (input_check(Inputs.RIGHT) && hsp < ACCEL_MAX && !stuck_left
			&& !(hsp > SLOW_THRESH && input_check(Inputs.SLOW) && feat_enabled_slow))
	{
		if (hsp > ACCEL_THRESH
				|| ((sign(hsp) == incline_dir && on_ground()) && hsp > 0))
			hsp += ACCEL_LO * delta;
		else if (on_ground())
			hsp += ACCEL_HI * delta;
		else if (hsp < ACCEL_THRESH)
			hsp += ACCEL_AIR * delta;
		if (hsp > SLOW_THRESH && input_check(Inputs.SLOW) && feat_enabled_slow)
			hsp = SLOW_THRESH;
	}
	
	if (!input_check(Inputs.LEFT)
			&& !input_check(Inputs.RIGHT))
	{
		var fric_dir = -sign(hsp);
		if (on_ground())
			hsp += fric_dir * FRIC_GRND * delta;
		else
			hsp += fric_dir * FRIC_AIR * delta;
		if (sign(hsp) == fric_dir)
			hsp = 0;
			hsp_part = 0;
	}
	
	if (abs(hsp) > ACCEL_MAX)
	{
		hsp = ACCEL_MAX * sign(hsp);
		hsp_part = 0;
	}
	
	if (abs(hsp) > INCLINE_MAX && sign(hsp) == incline_dir)
	{
		hsp -= incline_dir * INCLINE_ACC * delta;
		if (abs(hsp) < INCLINE_MAX)
			hsp = INCLINE_MAX * sign(hsp);
	}
	
	if (abs(hsp) > SLOW_THRESH && input_check(Inputs.SLOW) && feat_enabled_slow)
	{
		hsp -= sign(hsp) * SLOW_ACC * delta;
		if (abs(hsp) < SLOW_THRESH)
			hsp = SLOW_THRESH * sign(hsp);
	}
	
	
	// JUMPPING!!!!!
	if (on_ground())
		can_double_jump = true;

	if (input_check_pressed(Inputs.JUMP) && on_ground())
	{
		vsp = -JUMP_SPD;
		vsp_part = 0;
		audio_play_sound(Sfx_Jump, 10, false);
	}
	else if (input_check_pressed(Inputs.JUMP) && stuck_left)
	{
		vsp = -WALL_JUMP_VSPD;
		hsp = WALL_JUMP_HSPD;
		vsp_part = 0;
		audio_play_sound(Sfx_WallJump, 10, false);
	}
	else if (input_check_pressed(Inputs.JUMP) && stuck_right)
	{
		vsp = -WALL_JUMP_VSPD;
		hsp = -WALL_JUMP_HSPD;
		vsp_part = 0;
		audio_play_sound(Sfx_WallJump, 10, false);
	}
	else if (input_check_pressed(Inputs.JUMP) && can_double_jump)
	{
		vsp = -DOUBLE_JUMP_SPD;
		vsp_part = 0;
		can_double_jump = false;
		audio_play_sound(Sfx_DblJump, 10, false);
	}
	
	if (!on_ground())
	{
		if ((input_check(Inputs.JUMP) && vsp < GRAV_THRESH)
				|| vsp > FALL_THRESH)
			vsp += GRAV_LO * delta;
		else
			vsp += GRAV_HI * delta;
			
		if (input_check_released(Inputs.JUMP) && vsp < GRAV_THRESH)
			vsp *= JUMP_RELEASE;
	}
	
	if (vsp > FALL_MAX)
	{
		vsp = FALL_MAX;
		vsp_part = 0;
	}
	
	if (sliding_up_dir != 0)
	{
		vsp += FRIC_SLIDE_UP * delta;
		if (vsp > 0)
		{
			vsp = 0;
			vsp_part = 0;
		}
	}
	if (sliding_up_dir == -1)
	{
		if (hsp > vsp)
		{
			hsp = vsp;
			hsp_part = 0
		}
	}
	if (sliding_up_dir == 1)
	{
		if (hsp < -vsp)
		{
			hsp = -vsp;
			hsp_part = 0;
		}
	}
	
	was_on_left_wall = on_left_wall();
	was_on_right_wall = on_right_wall();
	
	process_movement(delta);
	
	if (is_hazard_at(0, 0, delta))
		die();
	
	end_inst = instance_position(x, y, Obj_EndZone);
	if (end_inst != noone)
	{
		global.just_died = false;
		SetMode(Modes.END);
		audio_play_sound(Sfx_Win, 10, false);
	}
	
	// ANIM8TIONZZZ
	if (stuck_left)
	{
		sprite_index = Spr_PlayerWall;
		image_xscale = 1;
	}
	else if (stuck_right)
	{
		sprite_index = Spr_PlayerWall;
		image_xscale = -1;
	}
	else if (!on_ground() && vsp <= 0)
	{
		sprite_index = Spr_PlayerJump;
	}
	else if (!on_ground() && vsp > 0)
	{
		sprite_index = Spr_PlayerFall;
	}
	else if (on_ground() && (input_check(Inputs.LEFT) || input_check(Inputs.RIGHT)))
	{
		if (decline_dir == 0)
		{
			sprite_index = Spr_PlayerWalk;
		}
		else
		{
			sprite_index = Spr_PlayerRun;
		}
	}
	else if (on_ground())
	{
		sprite_index = Spr_PlayerIdle;
	}
	
	if (decline_dir != 0)
	{
		image_xscale = decline_dir;
		audio_stop_sound(Sfx_Walk);
		if (!audio_is_playing(Sfx_Roll))
			audio_play_sound(Sfx_Roll, 10, true);
	}
	else if (!stuck_left && !stuck_right)
	{
		audio_stop_sound(Sfx_Roll);
		if (input_check(Inputs.LEFT))
		{
			image_xscale = -1;
			if (on_ground())
			{
				if (!audio_is_playing(Sfx_Walk))
					audio_play_sound(Sfx_Walk, 10, true);
			}
			else
				audio_stop_sound(Sfx_Walk);
		}
		else if (input_check(Inputs.RIGHT))
		{
			image_xscale = 1;
			if (on_ground())
			{
				if (!audio_is_playing(Sfx_Walk))
					audio_play_sound(Sfx_Walk, 10, true);
			}
			else
				audio_stop_sound(Sfx_Walk);
		}
		else
			audio_stop_sound(Sfx_Walk);
	}
	else
	{
		audio_stop_sound(Sfx_Walk);
		audio_stop_sound(Sfx_Roll);
	}
	
	if (on_ground() && !was_on_ground)
		audio_play_sound(Sfx_Land, 10, false);
	
	decline_dir = 0;
	was_on_ground = on_ground();
	

	var cam_dest_x = clamp(x - (view_wport[0] / 2), 
			0, room_width - view_wport[0]);
	var cam_dest_y = clamp(y - (view_hport[0] / 2), 
			0, room_height - view_hport[0]);
	camera_set_view_pos(view_camera[0], 
			lerp(camera_get_view_x(view_camera[0]), cam_dest_x, 0.1), 
			lerp(camera_get_view_y(view_camera[0]), cam_dest_y, 0.1));
}
else
{
	audio_stop_sound(Sfx_Walk);
	audio_stop_sound(Sfx_Roll);
}

if (GetMode() == Modes.END)
{
	var x_center = end_inst.x + end_inst.sprite_width / 2;
	var y_bottom = end_inst.y + end_inst.sprite_height;
	var y_off = bbox_bottom - y;
	x = lerp(x, x_center, .06);
	y = lerp(y, y_bottom - y_off, .06);
	
	sprite_index = Spr_PlayerWin;
	image_xscale = 1;
}

if (GetMode() == Modes.DIE)
{
	x += hsp * delta;
	y += vsp * delta;
	vsp += 1500 * delta;
	image_angle += rotvel;
	deathtimer--;
	if (deathtimer <= 0)
		room_restart();
	
	sprite_index = Spr_PlayerDie;
}
		
last_axislh = gamepad_axis_value(0, gp_axislh);
last_axislv = gamepad_axis_value(0, gp_axislv);