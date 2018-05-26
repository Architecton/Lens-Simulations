% function [] = run_simulation(fh, firstX, firstScaling, secondScaling, distanceScreens, rand, medium, lensMat, vis, multEnt)
%
% This is the function interfaced by the GUI of the program. The function
% accepts all the necessary parameters required to produces all the results
% required for the assignment.
%
% Authors: Kim Ana Badovinac, Katja Logar, Jernej Vivod
function [] = run_simulation(fh, firstX, firstScaling, secondScaling, distanceScreens, rand, medium, lensMat, vis, multEnt)

	% Add children of folder to path.
    folder = fileparts(which(mfilename)); 
    addpath(genpath(folder));

    % // First Screen Configuration ///////////////////////////////////
    
	% first screen x coordinate
    screen_x_position = firstX;
    
	% scaling factor for the first screen
    scaling_factor = firstScaling;

    % Define first screen spanning vectors.
    sv1 = [0; 0; -1];
    sv2 = [0; 1; 0];
    
    % Compute screen centering values (Used to center screen when scaling is applied).
    delta_scaling1 = ((norm(sv1) * scaling_factor) - norm(sv1)) / 2;
    delta_scaling2 = ((norm(sv2) * scaling_factor) - norm(sv2)) / 2;

    % Compute coordinates of the left upper corner of the first screen
    screen_lu_coordinates = [screen_x_position; -0.5 - delta_scaling2; 1 + delta_scaling1];

    % Apply scaling factor to first screen spanning vectors.
    sv1 = sv1 * scaling_factor;
    sv2 = sv2 * scaling_factor;

    % //////////////////////////////////////////////////////////////////

	
    % // Second Screen Configuration ///////////////////////////////////
    scaling_factor = secondScaling;

    % Define second screen spanning vectors.
    svf1 = [0; 0; -2];
    svf2 = [0; 2; 0];

    % Compute screen centering values (Used to center screen when scaling is applied).
    delta_scaling1 = ((norm(svf1) * scaling_factor) - norm(svf1)) / 2;
    delta_scaling2 = ((norm(svf2) * scaling_factor) - norm(svf2)) / 2;

    % Apply scaling factor to second screen spanning vectors.
    svf1 = svf1 * scaling_factor;
    svf2 = svf2 * scaling_factor;

    % Parse distance between screens.
	screen_distance = distanceScreens;

    % Compute coordinates of the left upper corner of the first screen
    finalScreen_lu_coordinates = [1 + screen_distance; -1 - delta_scaling2; 2 + delta_scaling1*2];

    % //////////////////////////////////////////////////////////////////

    % Set light source coordinates.
    light_source_coordinates = [0; 0; 0];

	% If choose random image...
    if rand
        % Load random image from CatDog set.	
        cd('test_images');	
        CatDog = load('CatDog.mat');
        CatDog = CatDog.CatDog;
        
        % Select random image from the CatDog set.
        ind = ceil(rand * size(CatDog,1));
        testing_image = reshape(CatDog(ind, :), 64, 64);
        
        cd('..');
	else
        cd('test_images');
		cat = load('cat_picture.mat');
        testing_image = cat.cat_picture;
        cd('..');
    end

    % Get matrix of coordinates of pixels on first screen.
    C = get_pixel_coordinates(screen_lu_coordinates, sv1, sv2, size(testing_image));

    % Construct line equations representing rays going through light source and pixle on first screen.
    F = make_line_functions(C, light_source_coordinates);

    % LENSING APPLICATION ####################################################################################

    % Set refraction indices for medium surrounding the lens and the lens material.

	switch medium
		case 1	
			lens.n1 = 1;
		case 2
			lens.n1 = 1.000277;
		case 3
			lens.n1 = 1.458; 
		case 4
			lens.n1 = 1.330;
		case 5
			lens.n1 = 1.31;
		case 6
			lens.n1 = 2.417;
	end

	switch lensMat
		case 1	
			lens.n2 = 1;
		case 2
			lens.n2 = 1.000277;
		case 3
			lens.n2 = 1.458; 
		case 4
			lens.n2 = 1.330;
		case 5
			lens.n2 = 1.31;
		case 6
			lens.n2 = 2.417;
	end

	
    % initialize lens with provided function handle representing and
    % implicit equation equated with 0.
	lens.equation = fh;

	% if visualize configuration...
    if vis
        im3 = figure('Name','Lens and Screens Configuration','NumberTitle','off');	
    end


    % lensing application	
    F_trans = apply_lensing_all(F, lens, vis, multEnt);

    % ########################################################################################################

    % Get instersection coordinates of rays with second screen.
    % The indices matrix stores the index of the pixel whose ray intersected.
    [intersections, indices] = get_intersections_finalScreen(F_trans, finalScreen_lu_coordinates, svf1, svf2);

    % Compute indices of pixels that were intersected by each ray.
    new_indices = get_intersection_indices(intersections, finalScreen_lu_coordinates, svf1, svf2, size(testing_image));

    % Get transformed image.
    transformed_image = get_transfromed_image(testing_image, indices, new_indices);

    % Initialize two figures - one for original image and one for transformed image.
    im1 = figure('Name','Original Image','NumberTitle','off');
    im2 = figure('Name','Transformed Image','NumberTitle','off');

	% Set figure to im1 (original image).
    figure(im1);
    % Display original image.
    imagesc(testing_image); colormap gray;
    title("Original Image");

    % Display transformed image.
	% Set figure to im2 (transformed image).
    figure(im2);
    h2 = imagesc(transformed_image); colormap gray;
    % Save result to res.jpg
    title("Transformed Image");
    saveas(h2, 'res.jpg');
    

    % additional code for the optional configuration visualization
	if vis
		% set figure appropriately
        figure(im3);
		
        % Plot vectors spanning the second screen.
        plot_finalScreen_frame(finalScreen_lu_coordinates, svf1, svf2);
        grid on;
        hold on;
        % Plot the light source as *
        plot_3d_vector(light_source_coordinates, 'r*');
        % Plot the vectors spanning the first screen.
        plot_screen(C);
        
		% Plot lens.
		fimplicit3(fh);
		
		% Set axis equal
        axis equal
	end
end