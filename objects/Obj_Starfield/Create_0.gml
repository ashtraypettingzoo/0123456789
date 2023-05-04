if (!variable_global_exists("starfield_p_system"))
{
	global.starfield_p_system = part_system_create_layer("Bg_Particles", true);
	global.starfield_particle = part_type_create();
	part_type_shape(global.starfield_particle,pt_shape_pixel);
	part_type_size(global.starfield_particle,1,1.5,.05,0);
	part_type_color2(global.starfield_particle,c_aqua, c_green);
	part_type_alpha2(global.starfield_particle,0, 1);
	part_type_speed(global.starfield_particle,.03,.03,0.30,0);
	part_type_direction(global.starfield_particle,0,359,0,0);
	part_type_orientation(global.starfield_particle,0,0,0,0,true);
	part_type_blend(global.starfield_particle,1);
	part_type_life(global.starfield_particle,60, 120); 
}