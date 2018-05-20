% function [intersections, indices] = get_intersections_finalScreen(line_functions, finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2)
%
% Compute intersections of lines representing the rays with the final screen.
%
% line_functions ... cell array containing line functions corresponding to each pixel in the first screen.
% finalScreen_lu_coordinates ... column vector representing the left upper corner of the second screen.
%	scaling_vector_1 ... vector scaling and directing the second screen
%	scaling_vector_2 ... vector scaling and directing the second screen
%
% Author: Jernej Vivod

function [intersections, indices] = get_intersections_finalScreen(line_functions, finalScreen_lu_coordinates, scaling_vector_1, scaling_vector_2)
  % Define matrices for storing the intersections coordinates
	% and the indices of each intersection.
	intersections = [];
  indices = [];
	
	% Go over line functions for individual pixels on the first screen.
  for k = 1:size(line_functions)(1)
    for l = 1:size(line_functions)(2)
      
			% Get next function.
      func = line_functions{k, l};
			
			% Computing intersection of line with plane //////////////////
			% Build A matrix (Ax = b).
      A_first_col = -(func(1) - func(0));      
      P01 = scaling_vector_1;
      P02 = scaling_vector_2;
      A_second_col = P01;
      A_third_col = P02;
      A = [A_first_col, A_second_col, A_third_col];
			% Build b vector.
      b = func(0) - finalScreen_lu_coordinates;
      
			% Solve for t, u and v (t is the line parameter, u and v are the coefficients of the plane spanning vectors).
      tuv = A\b;
      
			% Evaluate line equation at computed parameter to get coordinates of intersection.
      intersection = func(tuv(1, 1));
      
      % Check if intersection lies on finalScreen.
      scaling_vectors = [scaling_vector_1, scaling_vector_2];
      scaling_coefficients = scaling_vectors\(intersection - finalScreen_lu_coordinates);
      
			% If scaling coefficients for plane spanning vectors lie on [0, 1], the point is on the parallelogram spanned
			% by the two vectors.
      if !all(scaling_coefficients >= [0; 0]) || !all(scaling_coefficients <= [1; 1])
        continue
      endif
      
      % If it does, add to matrix of intersections.
      intersections = [intersections, intersection];
			
      % Add index of pixel whose ray intersected to indices array.
			% INDICES SWAPPED!!!
      indices = [indices, [k;l]];
      
    endfor
  endfor
  
endfunction