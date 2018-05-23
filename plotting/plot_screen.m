% function [] = plot_screen(pixel_coordinates)
%
% Auxiliary function that plots the pixels representing the
% first screen. Used for visualization and debugging.
% Author: Jernej Vivod

function [] = plot_screen(pixel_coordinates)
	A = pixel_coordinates{1, 1};
	B = pixel_coordinates{1, end};
	C = pixel_coordinates{end, 1};
	D = pixel_coordinates{end, end};
	l1 = plot3([A(1) B(1)], [A(2) B(2)], [A(3) B(3)], 'b');
	l2 = plot3([C(1) D(1)], [C(2) D(2)], [C(3) D(3)], 'b');
	l3 = plot3([A(1) C(1)], [A(2) C(2)], [A(3) C(3)], 'b');
	l4 = plot3([B(1) D(1)], [B(2) D(2)], [B(3) D(3)], 'b');
	
	set([l1 l2 l3 l4],'LineWidth',4);
endfunction