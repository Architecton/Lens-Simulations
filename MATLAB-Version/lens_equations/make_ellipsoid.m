function [fh] = make_ellipsoid(coordinates, r, factors)
	fh = @(x, y, z) ((x - coordinates(1)).^2)/factors(1).^2 + ((y - coordinates(2)).^2)/factors(2).^2 + ((z - coordinates(3)).^2)/factors(3).^2 - r^2;
end