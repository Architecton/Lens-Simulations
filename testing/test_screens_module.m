% Author Jernej Vivod
% // First Screen Configuration ///////////////////////////////////
scaling_factor = input("Enter first screen scaling factor: ");

% Define first screen spanning vectors.
v1 = [0; 0; -1];
v2 = [0; 1; 0];

% Compute screen centering values (Used to center screen when scaling is applied).
delta_scaling1 = ((norm(v1) * scaling_factor) - norm(v1)) / 2;
delta_scaling2 = ((norm(v2) * scaling_factor) - norm(v2)) / 2;

% Compute coordinates of the left upper corner of the first screen
screen_lu_coordinates = [1; -0.5 - delta_scaling2; 1 + delta_scaling1];

% Apply scaling factor to first screen spanning vectors.
v1 *= scaling_factor;
v2 *= scaling_factor;

% //////////////////////////////////////////////////////////////////

% // Second Screen Configuration ///////////////////////////////////
scaling_factor = input("Enter second screen scaling factor: ");

% Define second screen spanning vectors.
vf1 = [0; 0; -2];
vf2 = [0; 2; 0];

% Compute screen centering values (Used to center screen when scaling is applied).
delta_scaling1 = ((norm(vf1) * scaling_factor) - norm(vf1)) / 2;
delta_scaling2 = ((norm(vf2) * scaling_factor) - norm(vf2)) / 2;

% Apply scaling factor to second screen spanning vectors.
vf1 *= scaling_factor;
vf2 *= scaling_factor;

% Parse distance between screens.
screen_distance = input("Enter distance between screens: ");

% Compute coordinates of the left upper corner of the first screen
finalScreen_lu_coordinates = [1 + screen_distance; -1 - delta_scaling2; 2 + delta_scaling1*2];

% //////////////////////////////////////////////////////////////////

% Set light source coordinates.
light_source_coordinates = [0; 0; 0];

% Load image.
image_selection = input("Use random image? y/n ", 's');
if strcmp(image_selection, 'y')
	load CatDog.mat;
	testing_image = reshape(CatDog(ceil(rand()* size(CatDog)(1)), :), 64, 64); colormap gray;
else
	load cat_picture.m;
	testing_image = cat_picture;
endif

% Show original image
imagesc(testing_image); colormap gray;
title("Original Image");

% Get matrix of coordinates of pixels on first screen.
C = get_pixel_coordinates(screen_lu_coordinates, v1, v2, testing_image);

% Construct line equations representing rays going through light source and pixle on first screen.
F = make_line_functions(C, light_source_coordinates);

% Get instersection coordinates of rays with second screen.
% The indices matrix stores the index of the pixel whose ray intersected.
[intersections, indices] = get_intersections_finalScreen(F, finalScreen_lu_coordinates, vf1, vf2);

% Compute indices of pixels that were intersected by each ray.
new_indices = get_intersection_indices(intersections, finalScreen_lu_coordinates, vf1, vf2, size(testing_image));

% Get transformed image.
transformed_image = get_transfromed_image(testing_image, indices, new_indices);

% Display transformed image.
figure; imagesc(transformed_image); colormap gray;
title("Transformed Image");

% Optional: Plot the configurations of the light source, screens and rays in space.
plot_config = input("Plot configuration? y/n ", 's');
if strcmp(plot_config, "y")
	
	figure; plot_finalScreen_frame(finalScreen_lu_coordinates, vf1, vf2);
	grid on;
	hold on;
	plot_3d_vector(light_source_coordinates, 'r*');
	plot_screen(C);
	plot_rays(F);
	view(0,90);
	
endif