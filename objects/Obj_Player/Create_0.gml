feat_enabled_double_jump = true;
feat_enabled_slow = true;

hsp = 0;
vsp = 0;
hsp_part = 0;
vsp_part = 0;
incline_dir = 0;
sliding_up_dir = 0;
can_double_jump = false;

tilemap = layer_tilemap_get_id(layer_get_id("Tiles_Blocks"));

core_color = c_red;
core_col_timer = 0;
flicker_counter = 0;

end_inst = noone;

last_axislh = 0;
last_axislv = 0;

stick_ctr = 0;
was_on_right_wall = false;
was_on_left_wall = false;
stuck_left = false;
stuck_right = false;

rotvel = 0;
deathtimer = 0;
decline_dir = 0;

mask_index = Spr_Player;
was_on_ground = true;