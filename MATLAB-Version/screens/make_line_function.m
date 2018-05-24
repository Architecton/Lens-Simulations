% function [func] = make_line_function(pixel_coordinates, light_source_coodinates)
% 
% Make parametrized line function of a line going through the point representing the light source
% (specified by the light_source_coordinates vector) and the point specified by the
% pixel_coordinates vector.
%
% Author: Jernej vivod

function [func] = make_line_function(pixel_coordinates, light_source_coodinates)
 pixel_coordinates = cell2mat(pixel_coordinates);
 func = @(t) light_source_coodinates + t.*(pixel_coordinates - light_source_coodinates);
endfunction