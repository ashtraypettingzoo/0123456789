// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function GoToNextRoom(){
	if room_next(room) != -1
		room_goto_next();
	else
		room_goto(room_first);
}