% function [fh] = make_barthSextic(center, factors)
%
% Make function handle for implicit shape
%
function [fh] = make_barthSextic(center, factors)
  %function with center and stretch factors
  fh = @(x, y, z) 67.77708776.*factors(1).*(x-center(1)).^2.*factors(2).*(y-center(2)).^2.*factors(3).*(z-center(3)).^2-27.41640789.*factors(1).*(x-center(1)).^4.*factors(2).*(y-center(2)).^2-27.41640789.*factors(1).*(x-center(1)).^2.*factors(3).*(z-center(3)).^4+10.47213596.*factors(1).*(x-center(1)).^4.*factors(3).*(z-center(3)).^2-27.41640789.*factors(2).*(y-center(2)).^4.*factors(3).*(z-center(3)).^2+10.47213596.*factors(2).*(y-center(2)).^4.*factors(1).*(x-center(1)).^2+10.47213596.*factors(2).*(y-center(2)).^2.*factors(3).*(z-center(3)).^4-4.236067978.*factors(1).*(x-center(1)).^4-8.472135956.*factors(1).*(x-center(1)).^2.*factors(2).*(y-center(2)).^2-8.472135956.*factors(1).*(x-center(1)).^2.*factors(3).*(z-center(3)).^2+8.472135956.*factors(1).*(x-center(1)).^2-4.236067978.*factors(2).*(y-center(2)).^4-8.472135956.*factors(2).*(y-center(2)).^2.*factors(3).*(z-center(3)).^2+8.472135956.*factors(2).*(y-center(2)).^2-4.236067978.*factors(3).*(z-center(3)).^4+8.472135956.*factors(3).*(z-center(3)).^2-4.236067978;
end