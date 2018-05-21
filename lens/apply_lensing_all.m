% function [] = apply_lensing_all(line_equations)
% Apply the lensing function to all line equations representing the rays
%
% line_equations ... cell array of function handles representing the rays before lensing.
%
% Authors: Katja Logar, Kim Ana Badovinac, Jernej Vivod
function [transformed_line_equations] = apply_lensing_all(line_equations, lens)
	% Create optional code for plotting/visualization
	% IF NOT USED FOR PLOTTING/VISUALIZATION, ONLY THE FIRST RETURN VALUE OF apply_lensing FUNCTION IS NEEDED!
	transformed_line_equations = line_equations;
	for k = 1:size(line_equations)(1)
		for l = 1:size(line_equations)(2)
			ray_in = line_equations{k, l};
			[ray_out, ray_inside, t_in, t_out, intersections] = apply_lensing(ray_in, lens);
			transformed_line_equations(k, l) = ray_out;
			% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING #####################
			% Plot ray before hitting lens.
			plot_ray(ray_in, t_in);
			% Plot ray inside lens.
			plot_ray(ray_inside, t_out);
			% Plot ray after leaving lens.
			plot_ray(ray_out, 7);
			% ########################################################################
		endfor
	endfor
	
endfunction