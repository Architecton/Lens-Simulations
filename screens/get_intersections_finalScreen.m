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
	
	% Save original dimensions of the line_functions cell array
	original_dims = size(line_functions);
	
	% Reshape matrices to prepare for single parallelized for loop processing.	
	line_functions = reshape(line_functions, [1, numel(line_functions)]);
	intersections = zeros(3, length(line_functions));	
	indices = zeros(2, length(line_functions));
	
	% Go over line functions for individual pixels on the first screen.
  for k = 0:length(line_functions) - 1
		
		% Get next function.
		func = line_functions{k + 1};
		
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
        if ~all(scaling_coefficients >= [0; 0]) || ~all(scaling_coefficients <= [1; 1])
			continue
        end
		
		% If it does, add to matrix of intersections.
		intersections(:, k + 1) = intersection;
		
		% Add index of pixel whose ray intersected to indices array.
		indices(:, k + 1) = [fix(k / original_dims(1)) + 1; mod(k, original_dims(1)) + 1];
		
  end
  
	% Delete columns of all zeros.
	indices(:, ~any(indices, 1)) = [];
	intersections(:, ~any(intersections, 1)) = [];
	clear line_functions;
end