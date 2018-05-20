% function [] = plot_sphere(origin, scaling)
%
% Plot sphere with origin represented by the origin column vector of form [x; y; z].
% Scale the radius according to value of scaling variable (default is 1).
%
% Author: Jernej Vivod

function [] = plot_sphere(center, scaling)
	[x, y, z] = sphere;
	mesh(scaling*x + center(1), scaling*y + center(2), scaling*z + center(3));
	axis equal
endfunction
