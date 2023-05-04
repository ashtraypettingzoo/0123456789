x = ((camera_get_view_x(view_camera[0]) + view_wport[0] / 2) + (room_width / 2)) / 2;
y = ((camera_get_view_y(view_camera[0]) + view_hport[0] / 2) + (room_height / 2)) / 2;
part_particles_create(global.starfield_p_system, x, y, global.starfield_particle, 2);
