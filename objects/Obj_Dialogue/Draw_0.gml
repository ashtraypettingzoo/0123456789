draw_set_alpha(alpha);
draw_set_font(Fnt_Alagard);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
var col = make_color_hsv(hue_ctr * 255, 200, 200);
draw_text_color(
		x+3, y+3,
		caretctr >= 10 && ready ? line + "->" : line,
		col, col, col, col, alpha);
draw_text(
		x, y,
		caretctr >= 10 && ready ? line + "->" : line);
		
draw_set_alpha(1.);