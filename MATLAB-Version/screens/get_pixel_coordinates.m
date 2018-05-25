% function [pixel_coordinates] = get_pixel_coordinates(screen_lu_coordinates, scaling_vector_1, scaling_vector_2, image)
%
% Get coordinates of each picture representing the image on the first screen
%
% screen_lu_coordinates ... column vector containing the coordinates of the left uppoer corner of the first screen
% scaling_vector_1 ... the 1. first screen spanning vector
% scaling_vector_2 ... the 2. first screen spanning vector
%
% Author: Jernej Vivod
function [pixel_coordinates] = get_pixel_coordinates(screen_lu_coordinates, scaling_vector_1, scaling_vector_2, image_dims)

    % Get image dimensions.
    image_y_dim = image_dims(1);
    image_x_dim = image_dims(2);

    % Compute matrices of indices.
    [X, Y] = meshgrid(linspace(0, image_x_dim - 1, image_x_dim), linspace(0, image_y_dim - 1, image_y_dim));
    % Create index arrays on GPU
    % X = gpuArray(X);
    % Y = gpuArray(Y);

    % Get coordinates of each pixel of the screen (the image matrix)
    % pixel_coordinates = arrayfun(@(i, j) get_coordinates(i, j, scaling_vector_1, scaling_vector_2, image_dims, screen_lu_coordinates), Y, X, 'UniformOutput', false);

    % Prepare matrices for single for loop processing (parallelized).
    X = reshape(X, [1, numel(X)]);
    Y = reshape(Y, [1, numel(Y)]);

    % Create cell array for storing the coordinates.
    pixel_coordinates = cell(1, length(X));

    % Get coordinates of each pixel.
    for k = 1:length(X)
        pixel_coordinates{k} = get_coordinates(X(k), Y(k), scaling_vector_1, scaling_vector_2, image_dims, screen_lu_coordinates);
    end

    % Reshape to dimensions matching the original image.
    pixel_coordinates = reshape(pixel_coordinates, image_dims);
end