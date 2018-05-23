% Author: Jernej Vivod
vals = linspace(0.01, 2.5, 250);
	for k = 1:length(vals)
	% Define first screen spanning vectors.
	v1 = [0; 0; -1];
	v2 = [0; 1; 0];

	scaling_factor = 1;
	
	% Compute screen centering values (Used to center screen when scaling is applied).
	delta_scaling1 = ((norm(v1) * scaling_factor) - norm(v1)) / 2;
	delta_scaling2 = ((norm(v2) * scaling_factor) - norm(v2)) / 2;

	% Compute coordinates of the left upper corner of the first screen
	screen_lu_coordinates = [vals(k); -0.5 - delta_scaling2; 1 + delta_scaling1];

	% Apply scaling factor to first screen spanning vectors.
	v1 *= scaling_factor;
	v2 *= scaling_factor;

	% Define second screen spanning vectors.
	vf1 = [0; 0; -2];
	vf2 = [0; 2; 0];
	
	scaling_factor = 1.5;

	% Compute screen centering values (Used to center screen when scaling is applied).
	delta_scaling1 = ((norm(vf1) * scaling_factor) - norm(vf1)) / 2;
	delta_scaling2 = ((norm(vf2) * scaling_factor) - norm(vf2)) / 2;

	% Apply scaling factor to second screen spanning vectors.
	vf1 *= scaling_factor;
	vf2 *= scaling_factor;

	% Compute coordinates of the left upper corner of the first screen
	finalScreen_lu_coordinates = [3; -1 - delta_scaling2; 2 + delta_scaling1*2];

	% //////////////////////////////////////////////////////////////////

	% Set light source coordinates.
	light_source_coordinates = [0; 0; 0];

	load cat_picture.m;
	testing_image = cat_picture;

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
	
	figure; plot_finalScreen_frame(finalScreen_lu_coordinates, vf1, vf2);
	grid on;
	hold on;
	plot_3d_vector(light_source_coordinates, 'r*');
	plot_screen(C);
	plot_rays(F);
	view(0,90);
	title("Light Source, First Screen and Second Screen Configuration");
	name = sprintf("distance_animation2/%s.jpg", num2str(k,'%03.f'));
	saveas(gcf, name);
	close all
endfor