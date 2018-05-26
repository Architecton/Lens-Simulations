function [fh] = make_heart(center, factors)
	center = [center(2), center(1), center(3)];
	factors = [factors(2), factors(1), factors(3)];
	fh = @(y, x, z) ( 1/factors(1).^2 .* (x - center(1)).^2 + 1/factors(2).^2 .*  9/4 .* (y - center(2)).^2 + 1/factors(3).^2 .* (z - center(3)).^2 - 1).^3 - 1/factors(1).^2 .* (x - center(1)).^2 .* 1/factors(3).^2 .* (z - center(3)).^3 - (9/80) .* 1/factors(2).^2 .* (y - center(2)).^2 .* 1/factors(3).^2 .* (z - center(3)).^2;
end