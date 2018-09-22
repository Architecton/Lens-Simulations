% function [] = plot_intersections(intersections)
%
% Plot intersections as points in space. Auxiliary function used for
% visualization and debugging.
% Author: Jernej Vivod
function [] = plot_intersections(intersections)
	% Go over intersections and plot as point.
  parfor k = 1:length(intersections)
    vect = intersections(:, k);
    plot_3d_vector(vect, 'g*');
  end
end