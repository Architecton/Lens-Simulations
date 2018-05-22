function [intersection, t] = intersection_prototype(ray_in, lens_equation)
	% Get needed parameters for function which has zeros at t's where ray_in intersects with lens.	
	xyz = ray_in(0);	
	abc = ray_in(1) - ray_int(0);
	% Construct this function.
	g = @(t) lens_equation(xyz(0) + abc(0)*t, xyz(1) + abc(1)*t, xyz(2) + abc(2)*t);
	
	try
		t = fzero(g, [0.01, 10]);
		intersection = ray_in(t;)
	catch
		t = -1;
		intersection = [];
		return
	end_try_catch
	
endfunction
	