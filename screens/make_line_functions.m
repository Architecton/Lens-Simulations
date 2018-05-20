% function [line_functions] = make_line_functions(pixel_coordinates, light_source_coordinates)
%
% Make a cell array of function handles where a function with indices (i, j) corresponds 
% to a line between the point of the light source and the pixel at the first screen with indices (i, j).
%
% pixel_coordinates ... a cell array containing at indices (i, j) the coordinates of the pixel with indices (i, j)
% on the first screen.
% light_source_coordinates ... A column vector representing the (x, y, z) coordinates of the light source.
% Author: Jernej Vivod

function [line_functions] = make_line_functions(pixel_coordinates, light_source_coordinates)
	% Apply the make_line_function to each element of the pixel_coordinates cell array.
  line_functions = cellfun(@(p) make_line_function(p, light_source_coordinates), pixel_coordinates, 'UniformOutput', false);
endfunction
