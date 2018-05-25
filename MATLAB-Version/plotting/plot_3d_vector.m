% function [] = plot_3d_vector(vect, color)
%
%	Auxiliary function for plotting the point at the tip of a column vector of the form [x; y; z].
% vect ... the vector to plot
% color ... a string representing the color and style (same as similar argument to standard plot function) 
%
% Author: Jernej Vivod
function [] = plot_3d_vector(vect, color)
  plot3(vect(1), vect(2), vect(3), color);
  hold on;
end