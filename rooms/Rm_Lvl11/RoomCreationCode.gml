global.room_title = "mercury in cancer";

var spinner0 = instance_find(Obj_LaserSpinner, 0);
if (spinner0 != noone)
{
	spinner0.rotation_speed = 1;
	spinner0.radius = 300;
	spinner0.num_spokes = 5;
}

var spinner1 = instance_find(Obj_LaserSpinner, 1);
if (spinner1 != noone)
{
	spinner1.rotation_speed = 2;
	spinner1.radius = 300;
	spinner1.num_spokes = 5;
}

var spinner2 = instance_find(Obj_LaserSpinner, 2);
if (spinner2 != noone)
{
	spinner2.rotation_speed = 2.5;
	spinner2.radius = 300;
	spinner2.num_spokes = 5;
}