% function [fh] = make_torus(center, R, r)
% 
% Make function handle representing a torus.
%
% center ... vector containing the center coordinates of the torus.
% R ... radius from the middle of the hole to the center of the torus tube
% r ... radius of the torus tube
function [fh] = make_torus(center, R, r)
	center = [center(3), center(2), center(1)];
	fh = @(z, y, x) (R - sqrt((x - center(1)).^2 + (y - center(2)).^2)).^2 + (z - center(3)).^2 - r; 
end