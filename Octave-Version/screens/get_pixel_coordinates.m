% function [pixel_coordinates] = get_pixel_coordinates(screen_lu_coordinates, scaling_vector_1, scaling_vector_2, image)
%
% Get coordinates of each picture representing the image on the first screen
%
% screen_lu_coordinates ... column vector containing the coordinates of the left uppoer corner of the first screen
% scaling_vector_1 ... the 1. first screen spanning vector
% scaling_vector_2 ... the 2. first screen spanning vector
%
% Author: Jernej Vivod
function [pixel_coordinates] = get_pixel_coordinates(screen_lu_coordinates, scaling_vector_1, scaling_vector_2, image_dimensions)
  
  % Get image dimensions.
  image_y_dim = image_dimensions(1);
  image_x_dim = image_dimensions(2);
  
  % Compute matrices of indices.
  [X, Y] = meshgrid(linspace(0, image_x_dim - 1, image_x_dim), linspace(0, image_y_dim - 1, image_y_dim));
  
  % Get coordinates of each pixel of the screen (the image matrix)
  pixel_coordinates = arrayfun(@(i, j) get_coordinates(i, j, scaling_vector_1, scaling_vector_2, image_dimensions, screen_lu_coordinates), Y, X, 'UniformOutput', false);
endfunction