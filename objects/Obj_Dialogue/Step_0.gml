function button_check_pressed() 
{
	return (gamepad_is_connected(0) && gamepad_button_check_pressed(0, gp_face1))
			|| keyboard_check_pressed(vk_enter)
			|| keyboard_check_pressed(vk_space)
			|| keyboard_check_pressed(ord("Z"));
}

var numlines = array_length(global.lines);
var fullline = "";
if (global.curr_line < numlines) 
	fullline = global.lines[global.curr_line];
	
typectr++;
if (typectr > 2 && !done)
{
	typectr = 0;
	if (string_length(line) < string_length(fullline))
	{
		line = string_copy(fullline, 1, string_length(line) + 1);
		audio_play_sound(Sfx_Type, 10, false);
	}
	else
		ready = true;
}

if (ready == true && button_check_pressed() && !done)
{
	ready = false;
	global.curr_line++;
	if (global.curr_line >= numlines) 
	{
		done = true;
		charinst.done = true;
		audio_play_sound(Sfx_DlgEnd, 10, false);
	}
	else
	{
		line = "";
		audio_play_sound(Sfx_DlgNext, 10, false);
	}
}

if (done)
{
	alpha = lerp(alpha, 0, 0.1);
	if (alpha <= 0.05)
		GoToNextRoom();
}

hue_ctr = (hue_ctr + 0.01) % 1;
caretctr = (caretctr + 1) % 20;