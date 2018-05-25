function [intersection, t] = intersection_prototype(ray_in, lens_equation)
	% Get needed parameters for function which has zeros at t's where ray_in intersects with lens.	
	xyz = ray_in(0);	
	abc = ray_in(1) - ray_in(0);
    
	% Construct this function.
	g = @(t) lens_equation(xyz(1) + abc(1)*t, xyz(2) + abc(2)*t, xyz(3) + abc(3)*t);
	
    
    end_bracket = 0.1;
    try
        % approach zero with steps	
        initial_sign = sign(g(end_bracket));
        while sign(g(end_bracket)) == initial_sign
            end_bracket = end_bracket + 0.1;
            if (end_bracket > 2)
				t = -1;
				intersection = [];
				return
            end
        end
		t = fzero(g, [end_bracket - 0.2, end_bracket]);
		intersection = ray_in(t);
	catch
		t = -1;
		intersection = [];
		return
    end
	
end