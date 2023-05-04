draw_set_alpha(.6);
draw_rectangle_color(0, 0, room_width, room_height, 
		c_black, c_black, c_black, c_black, false);

draw_set_alpha(alpha);
draw_set_font(Fnt_Alagard);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(
		x, y,
		caretctr >= 10 && ready ? line + "->" : line);
		
draw_set_alpha(1.);