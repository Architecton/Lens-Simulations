% function [] = plot_ray(line_function, t_end)
%
% Plots line function representing a ray. Auxiliary function used for
% visualization and debugging.
%
% The starting point is assumed to be at the value of the function for parameter t == 0.
% The end parameter is specified by t_end (obtained from intersection finding functions).
%
% line_function ... a parametric line function representing a ray.
% t_end ... the parameter of the line equation which, given to the equation, gives the end point at which to stop plotting.
%
% Author: Jernej Vivod
function [] = plot_ray(line_function, t_end, color)	
	start_point = line_function(0);
	end_point = line_function(t_end);
	plot3([start_point(1), end_point(1)], [start_point(2), end_point(2)], [start_point(3), end_point(3)], color);
	hold on;
endfunction