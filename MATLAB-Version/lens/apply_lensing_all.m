% function [] = apply_lensing_all(line_equations)
% Apply the lensing function to all line equations representing the rays
%
% line_equations ... cell array of function handles representing the rays before lensing.
% lens ... structure representing the lens
% visualize ... if set to 1, the function will plot the rays as lines.
% multiple_entries ... If the lens shape could cause a ray to enter the
% lens multiple times, this is set to 1. Setting it to 0 for other types of
% lenses saves computation time.
%
% Authors: Katja Logar, Kim Ana Badovinac, Jernej Vivod
function [transformed_line_equations] = apply_lensing_all(line_equations, lens, visualize, multiple_entries)
	% Create optional code for plotting/visualization
	% IF NOT USED FOR PLOTTING/VISUALIZATION, ONLY THE FIRST RETURN VALUE OF apply_lensing FUNCTION IS NEEDED!
	% Reshape to row vector for use with parallelized for loop
	original_image_dimensions = size(line_equations);
	line_equations = reshape(line_equations, [1, numel(line_equations)]);
	transformed_line_equations = line_equations;
	
	% Go over all equations of lines rrepresenting the rays.
	% Use parallel for loop as computations for each ray are independent of other rays.
    for k = 1:length(line_equations)
		% Get equation of ray is it enters the lens.	
		ray_in = line_equations{k};
		
		% Apply lens transformation to the ray to get the ray as it leaves the lens.
		[ray_out, ray_inside, t_in, t_out] = apply_lensing(ray_in, lens);
		
		% ########################################################################
		% If there was no intersection with the lens, set ray_out equal to ray_in (no change)
        if isempty(ray_out)
			ray_out = ray_in;
			% go to next ray
			transformed_line_equations{k} = ray_out;
			
			% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING
			% If there was no intersection with the lens, plot ray_in function
			if visualize && mod(k, 100) == 0
				plot_ray(ray_out, 7, 'r');	
			end
			% ###################################################
			
			continue;
        end
		% ########################################################################
        ray_fin = ray_out;
		
		% If multiple entries into the lens are possible (This check is a runtime saving measure)
		found_additional_intersections = 0;
        if (multiple_entries)
			% If there was an intersection with the lens, check for any more intersections.
            while ~isempty(ray_out)
				% Save current ray_out.
				ray_fin = ray_out;
				% Set current ray_out as ray_in.
				ray_in_aux = ray_out;	
				% Try to find next intersection
				[ray_out, ray_inside_aux, t_in_aux, t_out_aux] = apply_lensing(ray_in_aux, lens);
				% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING #####################
				% Plot ray before hitting lens.
                if ~isempty(ray_out) && visualize
					found_additional_intersections = 1;	
					plot_ray(ray_in, t_in_aux, 'r');
					% Plot ray inside lens.
					plot_ray(ray_inside_aux, t_out_aux, 'y');
					% ########################################################################
                end
            end
        end
		% Put final equation representing the ray into the matrix containing the functions representing the rays.
        transformed_line_equations{k} = ray_fin;
		
		% OPTIONAL CODE USED FOR VISUALIZATION AND DEBUGGING
		% If there was an intersection with the lens plot ray before, ray inside and ray after lens.
        if visualize && mod(k, 100) == 0
            if(~found_additional_intersections)
				plot_ray(ray_in, t_in, 'r');
				plot_ray(ray_inside, t_out, 'g');
            end
			plot_ray(ray_fin, 5, 'b');
        end
		% #######################################################################
    end
    transformed_line_equations = reshape(transformed_line_equations, original_image_dimensions);
	
	clear line_equations;
end