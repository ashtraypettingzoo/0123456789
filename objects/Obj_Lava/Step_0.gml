var MAX_DELTA = 4.0 / 60.0;

var delta = delta_time / 1000000;
delta = min(delta, MAX_DELTA);

x = camera_get_view_x(view_camera[0]) - 10;

if (GetMode() == Modes.START)
{
	if (waitctr > 0)
	{
		y = camera_get_view_y(view_camera[0]) - 10;
		waitctr--;
	}
	else
	{
		y = lerp(y, room_height - 5, .07);
	}
}

if (GetMode() == Modes.END || GetMode() == Modes.DIE)
{
	y = lerp(y, camera_get_view_y(view_camera[0]) - 20, .05);
}

if (GetMode() == Modes.PLAY)
{
	y = room_height - 5;
	if (global.countdown > 0)
	{
		base_y = y;
		risewavectr = 0;
	}
	else
	{
		risewavectr = (risewavectr + 3 * delta) % (2 * pi);
		base_y -= delta * 95;
		y = max(base_y + 50 - 50*cos(risewavectr), -10);
		if (!audio_is_playing(Sfx_Lava))
			audio_play_sound(Sfx_Lava, 10, false);
	}
}

if (GetMode() == Modes.DIALOGUE)
{
	y = camera_get_view_y(view_camera[0]) - 20;
}

if (GetMode() == Modes.TITLE)
{
	
	if (global.titledone && !global.endscreen)
	{
		y = lerp(y, camera_get_view_y(view_camera[0]) - 20, 0.1);
	}
	else if (!global.endscreen)
		y = camera_get_view_y(view_camera[0]) + view_hport[0] + 20;
	else
		y = lerp(y, camera_get_view_y(view_camera[0]) + view_hport[0] + 20, 0.1);
}

wobblectr = (wobblectr + 0.023) % (2 * pi);
huectr = (huectr + 0.083) % 1;
linectr1 = (linectr1 + 0.145) % (2 * pi);
linectr2 = (linectr2 + 0.117) % (2 * pi);