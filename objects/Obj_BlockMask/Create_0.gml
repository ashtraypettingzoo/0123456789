var tilemap = layer_tilemap_get_id(layer_get_id("Tiles_Blocks"));

var surf = surface_create(room_width, room_height);
surface_set_target(surf);
draw_tilemap(tilemap, 0, 0);
surface_reset_target();

var spr = sprite_create_from_surface(surf, 0, 0, room_width, room_height, false, false, 0, 0);
sprite_collision_mask(spr, false, 0, 0, 0, room_width, room_height, bboxkind_precise, 0);
mask_index = spr;

// UNCOMMENT B4 LAUNCH !!!!!!
//layer_set_visible(layer_get_id("Tiles_Blocks"), false);