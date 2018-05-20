% function [intersection_indices] = get_intersection_indices(intersections, finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2, image_dimensions)
%
% Get indices of pixels that were intersected by rays going through first screen pixels.
%
% intersections ... matrix of coordinates of intersections of rays with the second screen.
% finalScreen_lu_coordinates ... column vector representing the left upper coordinate of the second screen
% scaling_vector_1 ... column vector representing the first spanning vector of the second screen
% scaling_vector_2 ... column vector representing the second spanning vector of the second screen
% image_dimensions ... a row vector representing the dimensions of the image on the second screen
%
% Author: Jernej Vivod

function [intersection_indices] = get_intersection_indices(intersections, finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2, image_dimensions)
	
	% Compute change of spanning vector scaling coefficient for change of one pixel.
	delta1 = 1/image_dimensions(1);
	delta2 = 1/image_dimensions(2);
	
	% Define matrix for storing indices of pixels that were intersected.
	intersection_indices = [];
	
	for k = 1:size(intersections)(2)
		intersection = intersections(:, k);
		
		% Get scaling coefficients for vectors spanning the final screen
		scaling_vectors = [scaling_vector_1, scaling_vector_2];
		scaling_coefficients = scaling_vectors\(intersection - finalScreen_lu_coordinates);
		
		% preemptive setting of values equal to 0 (would be ceiled to 0) to 1.
		if scaling_coefficients(1) == 0
			scaling_coefficients(1) = 1;
		endif
		
		if scaling_coefficients(2) == 0
			scaling_coefficients(2) = 1;
		endif
		
		% Use scaling coefficients to compute index of pixel on final screen.
		i = ceil(scaling_coefficients(1)/delta1);
		j = ceil(scaling_coefficients(2)/delta2);
		intersection_indices = [intersection_indices, [i; j]];
		
	endfor
endfunction