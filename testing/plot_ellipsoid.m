% function [] = plot_ellipsoid(center, scaling, stretch_factors)
%
% Plot sphere with origin represented by the origin column vector of form [x; y; z].
% Scale the radius according to value of scaling variable (default is 1).
%
% stretch 
%
% Author: Jernej Vivod

function [] = plot_ellipsoid(center, scaling, stretch_factors)
	[x, y, z] = sphere;
	mesh(stretch_factors(1)*scaling*x + center(1), stretch_factors(2)*scaling*y + center(2), stretch_factors(3)*scaling*z + center(3));
	axis equal
endfunction
