if (!done)
{
	y = lerp(y, camera_get_view_y(view_camera[0]) + view_hport[0], 0.1);
}
else
	y = lerp(y, 1500, 0.07);