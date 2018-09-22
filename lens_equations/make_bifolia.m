% function [fh] = make_bifolia(center, factors)
% 
% Make implicit function handle.

function [fh] = make_bifolia(center, factors)
	center = [center(2), center(1), center(3)];
	factors = [factors(2), factors(1), factors(3)];
	fh = @(y, x, z) 1/factors(1).^2 .* (x - center(1)).^4+1/factors(2).^2 .* (y - center(2)).^4+1/factors(3).^2 .* (z - center(3)).^4+2.* 1/factors(1).^2 .* (x - center(1)).^2.*1/factors(2) .* (y - center(2)).^2+2.*1/factors(1).^2 .* (x - center(1)).^2.*1/factors(3) .* (z - center(3)).^2+2.* 1/factors(2).^2 .* (y - center(2)).^2.*1/factors(3).^2 .* (z - center(3)).^2-3.*1/factors(1).^2 .* (y - center(2)).*1/factors(1).^2 .* (x - center(1)).^2-3.*1/factors(2).^2 .* (y - center(2)).*1/factors(3).^2 .* (z - center(3)).^2;
end