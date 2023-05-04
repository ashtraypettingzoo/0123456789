var MAX_DELTA = 4.0 / 60.0;

var delta = delta_time / 1000000;
delta = min(delta, MAX_DELTA);

if (GetMode() == Modes.PLAY)
{
	global.countdown = max(0, global.countdown - delta);
	alpha = lerp(alpha, 1, 0.1);
}
else
{
	alpha = lerp(alpha, 0, 0.1);
}