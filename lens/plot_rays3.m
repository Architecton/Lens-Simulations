% function [] = plot_rays3(line_functions, t_end)
%
% Plots line functions representing the rays. Auxiliary function used for
% visualization and debugging.
%
% The starting point is assumed to be at the value of the function for parameter t == 0.
% The end parameter is specified by t_end (obtained from intersection finding functions).
%
% line_functions ... a cell array representing the parametric functions of lines representing the rays.
% t_end ... the parameter of the line equation which, given to the equation, gives the end point at which to stop plotting.
%
% Author: Jernej Vivod
function [] = plot_rays3(line_functions, t_end)
		
	% Go over functions representing the rays and plot.
  for k = 1:size(line_functions)(1)
		func = line_functions{1, k};
		start_point = func(0);
		end_point = func(t_end);
		plot3([start_point(1), end_point(1)], [start_point(2), end_point(2)], [start_point(3), end_point(3)], 'r');
  endfor
endfunction