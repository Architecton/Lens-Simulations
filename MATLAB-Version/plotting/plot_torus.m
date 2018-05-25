% function [] = plot_torus(R, r, center)
%
% Auxiliary function used for visualizations and debugging. Plot
% torus with specified radii and center.
%
% R ... outer radius
% r ... inner radius
% center ... vector of the form [x, y, z] specifying the center of the torus
%
% Author: Jernej Vivod
function [] = plot_torus(R, r, center)
	theta = linspace(0,2*pi,36);
	phi = linspace(0,2*pi,18);
	[Phi,theta] = meshgrid(phi, theta); 
	x = (R + r.*cos(theta)) .* cos(phi);
	y = (R + r.*cos(theta)) .* sin(phi);
	z = r.*sin(theta);
	h = mesh(x - center(1), y - center(2), z - center(3));
	rotate(h, [0 1 0], 90);
	axis equal
end
	