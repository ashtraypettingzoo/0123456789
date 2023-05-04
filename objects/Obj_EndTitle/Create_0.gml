line = "";
typectr = 0;
ready = false;
done = false;
alpha = 1;
hue_ctr = 0;
caretctr = 0;
global.just_died = true;
if (audio_is_playing(Bgm_01))
	audio_stop_sound(Bgm_01);

global.titledone = false;
global.endscreen = true;
SetMode(Modes.TITLE);