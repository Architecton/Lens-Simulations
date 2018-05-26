function [] = make_frames2()
    folder = fileparts(which(mfilename)); 
    addpath(genpath(folder));

	gif('myfile.gif','DelayTime',0.1,'LoopCount',5,'frame',gcf)
	%im3 = figure('Name','Lens and Screens Configuration','NumberTitle','off');	
    % Authors Kim Ana Badovinac, Katja Logar, Jernej Vivod
    % // First Screen Configuration ///////////////////////////////////
    vals = linspace(0.1, 1.4, 200);
    for frame = 1:length(vals)
        screen_x_position = 1;

        scaling_factor = 1;

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
        scaling_factor = 3;

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
        screen_distance = 6;

        % Compute coordinates of the left upper corner of the first screen
        finalScreen_lu_coordinates = [1 + screen_distance; -1 - delta_scaling2; 2 + delta_scaling1*2];

        % //////////////////////////////////////////////////////////////////

        % Set light source coordinates.
        light_source_coordinates = [0; 0; 0];

		cat = load('cat.mat');
        testing_image = cat.cat;
        % Get matrix of coordinates of pixels on first screen.
        C = get_pixel_coordinates(screen_lu_coordinates, sv1, sv2, size(testing_image));

        % Construct line equations representing rays going through light source and pixle on first screen.
        F = make_line_functions(C, light_source_coordinates);

        % LENSING APPLICATION ####################################################################################

        % Prompt for lens shape (let user choose from set of predefined equations)
        
        while(1)
            n = 2;
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

        while(1)
            n = 3;
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
        lens.equation = @(x, y, z) ((x - 3).^2)/vals(frame)^2 + y.^2 + (z - 1).^2 - 0.64;

        
      


        % lensing application

        % MULTIPLE ENTRIES --- THIS IS SET WHEN THE USER CHOOSES THE LENS SHAPE
        % IF SHAPE IS CONCAVE THIS VALUE SHOULD BE SET TO 1 AND 0 OTHERWISE
        multiple_entries = 0;
        F_trans = apply_lensing_all(F, lens, 0, multiple_entries);

        % ########################################################################################################

        % Get instersection coordinates of rays with second screen.
        % The indices matrix stores the index of the pixel whose ray intersected.
        [intersections, indices] = get_intersections_finalScreen(F_trans, finalScreen_lu_coordinates, svf1, svf2);

        % Compute indices of pixels that were intersected by each ray.
        new_indices = get_intersection_indices(intersections, finalScreen_lu_coordinates, svf1, svf2, size(testing_image));

        % Get transformed image.
        transformed_image = get_transfromed_image(testing_image, indices, new_indices);

        % Initialize two figures - one for original image and one for transformed image.
        im2 = figure('Name','Transformed Image','NumberTitle','off');

        % Display transformed image.
        figure(im2);
        h2 = imagesc(transformed_image); colormap gray;
        % Save result to res.jpg
        %title("Transformed Image");
        %frame_name = sprintf('a/%d.jpg', frame);
        %saveas(h2, frame_name);
        

        % Additional code for the optional visualization function.
        % visualize_bin was set when user was prompted for ray and screen visualization choice.
        %figure(im3);
        % Plot vectors spanning the second screen.
        %plot_finalScreen_frame(finalScreen_lu_coordinates, svf1, svf2);
        %grid on;
        %hold on;
        % Plot the light source as *
        %plot_3d_vector(light_source_coordinates, 'r*');
        % Plot the vectors spanning the first screen.
        %plot_screen(C);
        % If user chose to plot lens...
        %plot_ellipsoid([3; 0; 1], 0.8, [vals(frame); 1; 1]);
        %axis equal
		% axis();
        %view(-60, 45);
		%axis([0 15 -4 4 0 6])
		%grid on
        %frame_name = sprintf('c/%d.jpg', frame);
        %saveas(gcf, frame_name);
		
		%camlight
		
		%view(0, 90);
		if frame == 1
			gif('myfile.gif','DelayTime',0.2,'LoopCount',5,'frame',gcf);
		end
		gif
		% frame_name = sprintf('d/%d.jpg', frame);
		% saveas(gcf, frame_name);
		clf
    end
end