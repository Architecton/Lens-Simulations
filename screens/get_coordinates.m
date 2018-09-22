% function [coordinates] = get_coordinates(i, j, scaling_vector_1, scaling_vector_2, image_dimensions, screen_lu_coordinates)
%
% Return coordinates of pixel with indices (i, j) on first screen spanned by scaling_vector_1 and scaling_vector_2
%
% i ... the first index of the pixel on the first screen
% j ... the second index of the pixel on the first screen
% scaling_vector_1 ... the 1. first screen spanning vector
% scaling_vector_2 ... the 2. first screen spanning vector
% image_dimensions ... row vector containing the dimensions (in pixels) of the image on the first screen 
% screen_lu_coordinates ... column vector represening the left upper corner of the first screen
%
% Author: Jernej Vivod
function [coordinates] = get_coordinates(i, j, scaling_vector_1, scaling_vector_2, image_dimensions, screen_lu_coordinates)
	% The following two formulas are NOT CORRECT as they are not analogous to the methods of computing indices from coorinates on the second screen!	
    % coordinates = screen_lu_coordinates + (i/(image_dimensions(1) - 1)).*scaling_vector_1 + (j/(image_dimensions(2) - 1)).*scaling_vector_2;
	% coordinates = screen_lu_coordinates + (i*(1/(image_dimensions(1) - 1))).*scaling_vector_1 + (j*(1/(image_dimensions(2) - 1))).*scaling_vector_2;
	
	% Compute "nudges" or deltas required to adjust the coordinates to the centre of a square on the screen representing the pixel.
	delta1 = (1/image_dimensions(1)) / 2;
	delta2 = (1/image_dimensions(2)) / 2;
	
	% Compute coordinates of centre of square on first screen representing a pixel with indices (i, j)
	coordinates = screen_lu_coordinates + ((i/image_dimensions(1)) + delta1 ).*scaling_vector_1 + ((j/image_dimensions(2)) + delta2).*scaling_vector_2;
end