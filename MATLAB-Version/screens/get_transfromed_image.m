% function [transformed_image] = get_transfromed_image(testing_image, indices, new_indices)
%
% Get the final transformed image (result of tracing the rays).
%
% testing_image ... The image on the screens
% indices ... The original indices of the rays that intersected
% new_indices ... The indices of the the pixel that the ray intersected.
% Author: Jernej Vivod
function [transformed_image] = get_transfromed_image(testing_image, indices, new_indices)
	% Prepare blank image.
	transformed_image = uint8(zeros(size(testing_image)));
	
	% TO GPU ARRAY (both testing image and transformed image)
	
	% Go over all pixels that intersected
    for k = 1:length(indices)
		% Transform the pixel to the color of the pixel that the ray intersected.	
		transformed_image(indices(1, k), indices(2, k), :) = testing_image(new_indices(1, k), new_indices(2, k), :);
    end
	
	% TRANSFORMED IMAGE BACK TO CPU ARRAY
	
end