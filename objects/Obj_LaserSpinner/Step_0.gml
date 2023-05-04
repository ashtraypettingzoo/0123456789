var MAX_DELTA = 4.0 / 60.0;

var delta = delta_time / 1000000;
delta = min(delta, MAX_DELTA);

curr_lfo_counter = (curr_lfo_counter + lfo_freq * delta) % (2 * pi);
var lfo_val = lfo_amp * sin(curr_lfo_counter + lfo_phase);
base_theta = (base_theta + (rotation_speed + lfo_val) * delta) % (2 * pi);
curr_theta = base_theta + rotation_offset;

function next_theta(delta)
{
	var next_lfo_counter = (curr_lfo_counter + lfo_freq * delta) % (2 * pi);
	var lfo_val = lfo_amp * sin(next_lfo_counter + lfo_phase);
	var next_base_theta = (base_theta + (rotation_speed + lfo_val) * delta) % (2 * pi);
	return next_base_theta + rotation_offset;
}

function collides_with_player(player_x, player_y, delta)
{
	var DIST_THRESH = 6;
	var retval = false;
	var player_theta = arctan2(player_y - y, player_x - x);
	for (var i = 0; i < num_spokes; i++)
	{
		var theta1 = curr_theta + 2 * pi * i / num_spokes;
		var theta2 = next_theta(delta) + 2 * pi * i / num_spokes;
		var rad = min(radius, distance_to_point(player_x, player_y));
		var x1 = x + rad * cos(theta1);
		var y1 = y + rad * sin(theta1);
		var x2 = x + rad * cos(theta2);
		var y2 = y + rad * sin(theta2);
		var x3 = x + rad * cos(player_theta);
		var y3 = y + rad * sin(player_theta);
		
		if (sqrt((x1 - player_x) * (x1 - player_x) + (y1 - player_y) * (y1 - player_y)) <= DIST_THRESH)
			retval = true;
		if (sqrt((x2 - player_x) * (x2 - player_x) + (y2 - player_y) * (y2 - player_y)) <= DIST_THRESH)
			retval = true;
		if (abs(angle_difference(theta1, player_theta)) <= abs(angle_difference(theta2, player_theta))
				&& abs(angle_difference(player_theta, theta2)) <= abs(angle_difference(theta1, theta2))
				&& sqrt((x3 - player_x) * (x3 - player_x) + (y3 - player_y) * (y3 - player_y)) <= DIST_THRESH)
			retval = true;
	}
	return retval;
}