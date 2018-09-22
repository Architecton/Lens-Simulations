% function [] = plot_finalScreen_frame(finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2)
%
% Auxiliary function for plotting a visual representation of the second screen spanning vectors
%
% Author: Jernej Vivod

function [] = plot_finalScreen_frame(finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2)
  x_coordinates = [finalScreen_lu_coordinates(1), finalScreen_lu_coordinates(1) + scaling_vector_1(1)];
  y_coordinates = [finalScreen_lu_coordinates(2), finalScreen_lu_coordinates(2) + scaling_vector_1(2)];
  z_coordinates = [finalScreen_lu_coordinates(3), finalScreen_lu_coordinates(3) + scaling_vector_1(3)];
  h1 = plot3(x_coordinates, y_coordinates, z_coordinates, 'g');
  
  hold on;
  
  x_coordinates = [finalScreen_lu_coordinates(1), finalScreen_lu_coordinates(1) + scaling_vector_2(1)];
  y_coordinates = [finalScreen_lu_coordinates(2), finalScreen_lu_coordinates(2) + scaling_vector_2(2)];
  z_coordinates = [finalScreen_lu_coordinates(3), finalScreen_lu_coordinates(3) + scaling_vector_2(3)];
  h2 = plot3(x_coordinates, y_coordinates, z_coordinates, 'g');
  
  set([h1 h2],'LineWidth',4);
	
end