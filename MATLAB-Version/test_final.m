function [] = test_final()
    folder = fileparts(which(mfilename)); 
    addpath(genpath(folder));

    % Authors Kim Ana Badovinac, Katja Logar, Jernej Vivod
    % // First Screen Configuration ///////////////////////////////////

    % FOCUS -- USE 1 2 2.9 combination

    % UI instructions
    fprintf("The light source is fixed at point (0, 0, 0).\n");
    fprintf("The first screen is at a fixed distance of 1 from the light source.\n");
    fprintf("The default length of the side of the first screen is 1 and can be scaled.\n");
    fprintf("\n");
    
    prompt = 'Enter first screen scaling factor: ';
    scaling_factor = input(prompt);

    % Define first screen spanning vectors.
    sv1 = [0; 0; -1];
    sv2 = [0; 1; 0];
    
    % Compute screen centering values (Used to center screen when scaling is applied).
    delta_scaling1 = ((norm(sv1) * scaling_factor) - norm(sv1)) / 2;
    delta_scaling2 = ((norm(sv2) * scaling_factor) - norm(sv2)) / 2;

    % Compute coordinates of the left upper corner of the first screen
    screen_lu_coordinates = [1; -0.5 - delta_scaling2; 1 + delta_scaling1];

    % Apply scaling factor to first screen spanning vectors.
    sv1 = sv1 * scaling_factor;
    sv2 = sv2 * scaling_factor;

    % //////////////////////////////////////////////////////////////////

    % // Second Screen Configuration ///////////////////////////////////
    fprintf("\nThe default length of a side of the second screen is 2 and can be scaled.\n");
    fprintf("\n");
    prompt = 'Enter second screen scaling factor ';
    scaling_factor = input(prompt);

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
    prompt = '\nEnter distance between screens: ';
    screen_distance = input(prompt);

    % Compute coordinates of the left upper corner of the first screen
    finalScreen_lu_coordinates = [1 + screen_distance; -1 - delta_scaling2; 2 + delta_scaling1*2];

    % //////////////////////////////////////////////////////////////////

    % Set light source coordinates.
    light_source_coordinates = [0; 0; 0];

    % Let user choose image
    prompt = '\nUse random image? y/n ';
    image_selection = input(prompt, 's');
    if strcmp(image_selection, 'y')
        % Load random image from CatDog set.	
        cd('test_images');	
        CatDog = load('CatDog.mat');
        CatDog = CatDog.CatDog;
        
        ind = ceil(rand * size(CatDog,1));
        testing_image = reshape(CatDog(ind, :), 64, 64);
        
        cd('..');
    else
        % Load the cat_picture.m image.
        %load cat_picture.m;
        %testing_image = cat_picture;
        %cd('test_images');
        %load im.m;
        testing_image = rand(16, 16);
    end

    % Get matrix of coordinates of pixels on first screen.
    C = get_pixel_coordinates(screen_lu_coordinates, sv1, sv2, size(testing_image));

    % Construct line equations representing rays going through light source and pixle on first screen.
    F = make_line_functions(C, light_source_coordinates);

    % LENSING APPLICATION ####################################################################################

    % Prompt for lens shape (let user choose from set of predefined equations)

    % Prompt for n1 and n2. Let users choose from list of materials.
    fprintf("\nSelect the medium surrounding the lens:\n");
    fprintf("1 --- Vacuum\n2 --- Air\n3 --- Glass\n4 --- Water\n5 --- Ice\n6 --- Diamond\n7 --- Custom Value\n");

    while(1)
        prompt = '';
        n = input(prompt);
        switch n
            case 1	
                lens.n1 = 1;
                break;
            case 2
                lens.n1 = 1.000277;
                break;
            case 3
                lens.n1 = 1.458; 
                break;
            case 4
                lens.n1 = 1.330;
                break;
            case 5
                lens.n1 = 1.31;
                break;
            case 6
                lens.n1 = 2.417;
                break;
            case 7
                prompt = 'Enter refraction index: ';
                lens.n1 = input(prompt);
                break;
            otherwise
                fprintf("Please enter a valid option.\n");
        end
    end

    % Prompt for n1 and n2. Let users choose from list of materials.
    fprintf("\nSelect material the lens is made of:\n");
    fprintf("1 --- Vacuum\n2 --- Air\n3 --- Glass\n4 --- Water\n5 --- Ice\n6 --- Diamond\n7 --- Custom Value\n");

    while(1)
        prompt = '';
        n = input(prompt);
        switch n
            case 1	
                lens.n2 = 1;
                break;
            case 2
                lens.n2 = 1.000277;
                break;
            case 3
                lens.n2 = 1.458; 
                break;
            case 4
                lens.n2 = 1.330;
                break;
            case 5
                lens.n2 = 1.31;
                break;
            case 6
                lens.n2 = 2.417;
                break;
            case 7
                prompt = 'Enter refraction index: ';
                lens.n2 = input(prompt);
                break;
            otherwise
                fprintf("Please enter a valid option.\n");
        end
    end


    %fprintf("\nSelect shape of lens:\n");
    %fprintf("TODO");

    % initialize lens
    lens.equation = @(x, y, z) (x - 2.5).^2 + y.^2 + (z - 1).^2 - 0.64;

    % Prompt user for choice of input visualization.
    prompt = '\nVisualize lens intersecting rays and screens? (WARNING: slow for large images) y/n ';
    visualize = input(prompt, 's');
    visualize_bin = 0;
    plot_shape = 'n';
    if strcmp(visualize, 'y')
        prompt = 'Plot lens? (WARNING: only works in MATLAB) y/n ';
        plot_shape = input(prompt, 's');	
        visualize_bin = 1;
        im3 = figure('Name','Lens and Screens Configuration','NumberTitle','off');	
    end


    % lensing application

    % MULTIPLE ENTRIES --- THIS IS SET WHEN THE USER CHOOSES THE LENS SHAPE
    % IF SHAPE IS CONCAVE THIS VALUE SHOULD BE SET TO 1 AND 0 OTHERWISE
    multiple_entries = 0;
    F_trans = apply_lensing_all(F, lens, visualize_bin, multiple_entries);

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

    figure(im1);
    % Display original image.
    imagesc(testing_image); colormap gray;
    title("Original Image");

    % Display transformed image.
    figure(im2);
    h2 = imagesc(transformed_image); colormap gray;
    % Save result to res.jpg
    saveas(h2, 'res.jpg');
    title("Transformed Image");

    % Additional code for the optional visualization function.
    % visualize_bin was set when user was prompted for ray and screen visualization choice.
    if visualize_bin
        figure(im3);
        % Plot vectors spanning the second screen.
        plot_finalScreen_frame(finalScreen_lu_coordinates, svf1, svf2);
        grid on;
        hold on;
        % Plot the light source as *
        plot_3d_vector(light_source_coordinates, 'r*');
        % Plot the vectors spanning the first screen.
        plot_screen(C);
        % If user chose to plot lens...
        if(strcmp(plot_shape, "y"))
            plot_ellipsoid([2.5; 0; 1], 0.8, [1; 1; 1]);
        end
        axis equal
    end
    fprintf("\nDone. The transformed image was saved to 'res.jpg'\n");
end