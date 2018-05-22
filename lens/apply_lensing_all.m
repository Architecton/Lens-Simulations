% function [] = apply_lensing_all(line_equations)
% Apply the lensing function to all line equations representing the rays
%
% line_equations ... cell array of function handles representing the rays before lensing.
%
% Authors: Katja Logar, Kim Ana Badovinac, Jernej Vivod
function [transformed_line_equations] = apply_lensing_all(line_equations, lens, visualize)
	% Create optional code for plotting/visualization
	% IF NOT USED FOR PLOTTING/VISUALIZATION, ONLY THE FIRST RETURN VALUE OF apply_lensing FUNCTION IS NEEDED!
	transformed_line_equations = line_equations;
	
	% Go over all equations of lines rrepresenting the rays.
	for k = 1:size(line_equations)(1)
		for l = 1:size(line_equations)(2)
			% Get equation of ray is it enters the lens.	
			ray_in = line_equations{k, l};
			
			% Apply lens transformation to the ray to get the ray as it leaves the lens.
			[ray_out, ray_inside, t_in, t_out] = apply_lensing(ray_in, lens);
			
			% ########################################################################
			% If there was no intersection with the lens, set ray_out equal to ray_in (no change)
			if isempty(ray_out)
				ray_out = ray_in;
				% go to next ray
				transformed_line_equations(k, l) = ray_out;
				
				% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING
				if visualize
					% TODO					
				endif
				
				continue;
			endif
			% ########################################################################
			
			% If there was an intersection with the lens, check for any more intersections.
			while !isempty(ray_out)
				% Save current ray_out.
				ray_fin = ray_out;
				% Set current ray_out as ray_in.
				ray_in = ray_out;	
				% Try to find next intersection
				[ray_out, ray_inside, t_in, t_out] = apply_lensing(ray_in, lens);
				% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING #####################
				% Plot ray before hitting lens.
				if !isempty(ray_out) && visualize
					plot_ray(ray_in, t_in);
					% Plot ray inside lens.
					plot_ray(ray_inside, t_out);
					% ########################################################################
				endif
			endwhile	
			% Put final equation representing the ray into the matrix containing the functions representing the rays.
			transformed_line_equations(k, l) = ray_fin;
			
			% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING
			% Plot ray after leaving lens (7 is an arbitrary value and can be changed).
			if visualize
				plot_ray(ray_out, 7);
			endif
			% ########################################################################
		endfor
	endfor
	
endfunction