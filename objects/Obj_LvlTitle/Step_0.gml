hue_ctr = (hue_ctr + 0.01) % 1;

x_left = lerp(x_left, 0, .04);

fadetimer--;
if (fadetimer <= 0)
{
	x_right = lerp(x_left, 0, .04);
	if (x_right < 50)
		alpha = lerp(alpha, 0, .1);
	if (alpha <= 0.05)
		instance_destroy();
}
else
	alpha = lerp(alpha, 1, .1);