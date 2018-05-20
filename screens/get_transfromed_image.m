% function [transformed_image] = get_transfromed_image(testing_image, indices, new_indices)
%
% Get the final transformed image (result of tracing the rays).
%
% testing_image ... The image on the screens
% indices ... The original indices of the rays that intersected
% new_indices ... The indices of the the pixel that the ray intersected.
% Author: Jernej Vivod
function [transformed_image] = get_transfromed_image(testing_image, indices, new_indices)
	% Prepare blank image	
	transformed_image = zeros(size(testing_image));
	% Go over all pixels that intersected
	for k = 1:size(indices)(2)
		% Transform the pixel to the color of the pixel that the ray intersected.	
		transformed_image(indices(:, k)(1), indices(:, k)(2)) = testing_image(new_indices(:, k)(1), new_indices(:, k)(2));
	endfor
endfunction

		