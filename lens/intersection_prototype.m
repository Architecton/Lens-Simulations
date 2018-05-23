function [intersection, t] = intersection_prototype(ray_in, lens_equation)
	% Get needed parameters for function which has zeros at t's where ray_in intersects with lens.	
	xyz = ray_in(0);	
	abc = ray_in(1) - ray_in(0);
	% Construct this function.
	g = @(t) lens_equation(xyz(1) + abc(1)*t, xyz(2) + abc(2)*t, xyz(3) + abc(3)*t);
	
	try
		% approach zero with steps	
		end_bracket = 0.1;
		initial_sign = sign(g(end_bracket));
		while sign(g(end_bracket)) == initial_sign
			end_bracket += 0.1;
			if(end_bracket > 5)
				t = -1;
				intersection = [];
				return
			endif
		endwhile
		t = fzero(g, [end_bracket - 0.2, end_bracket]);
		intersection = ray_in(t);
		% Optional visualization/debugging code  ////
		%addpath(genpath('/home/jernej/Dropbox/MM/HAs/Lens-Simulations/screens'));
		%plot_3d_vector(intersection, 'yo');
		% ///////////////////////////////////////////
	catch
		t = -1;
		intersection = [];
		return
	end_try_catch
	
endfunction