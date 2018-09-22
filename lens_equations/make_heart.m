% function [fh] = make_heart(center, factors)
% 
% Make function handle of implicit surface.
function [fh] = make_heart(center, factors)
	fh = @(x, y, z) (2.*(1/factors(1).^2).*(x-center(1)).^2+2.*(1/factors(2).^2).*(y-center(2)).^2+(1/factors(3).^2).*(z-center(3)).^2-1).^3-1./(10).*(1/factors(1)).*(x-center(1)).^2.*(1/factors(3).^2).*(z-center(3)).^3-(1/factors(2).^2).*(y-center(2)).^2.*(1/factors(1).^2).*(z-center(3)).^3;
end