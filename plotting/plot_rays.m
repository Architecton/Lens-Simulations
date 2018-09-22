% function [] = plot_rays(line_functions)
%
% Plots line functions representing the rays. Auxiliary function used for
% visualization and debugging.
% Author: Jernej Vivod
function [] = plot_rays(line_functions)
	% Set limit for t.	
	limit = 7;	
	% Go over functions representing the rays and plot.
    [loop_lim_1, loop_lim_2] = size(line_functions);
    for k = 1:loop_lim_1
        for l = 1:loop_lim_2
			func = line_functions{k, l};
			start_point = func(0);
			end_point = func(limit);
			plot3([start_point(1), end_point(1)], [start_point(2), end_point(2)], [start_point(3), end_point(3)], 'r');
        end
    end
end