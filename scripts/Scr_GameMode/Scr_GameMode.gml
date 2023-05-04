enum Modes
{
	START,
	PLAY,
	END,
	DIE,
	DIALOGUE,
	TITLE
}

function GetMode()
{
	if (!variable_global_exists("mode"))
	{
	    global.mode = Modes.START;
	}
	return global.mode
}

function SetMode(mode)
{
	global.mode = mode;
}