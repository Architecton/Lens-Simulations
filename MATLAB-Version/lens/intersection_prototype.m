% function [intersection, t] = intersection_prototype(ray_in, lens_equation)
% Find intersection of parametrized line function representing a ray with
% the lens represented by the lens_equation.
%
% ray_in ... parametrized line function representing a ray.
% lens_equation ... parametric equation of the lens.

function [intersection, t] = intersection_prototype(ray_in, lens_equation)
	% Get needed parameters for function which has zeros at t's where ray_in intersects with lens.	
	xyz = ray_in(0);	
	abc = ray_in(1) - ray_in(0);
    
	% Construct this function.
	g = @(t) lens_equation(xyz(1) + abc(1)*t, xyz(2) + abc(2)*t, xyz(3) + abc(3)*t);
	
    % Start approaching possible root from t = 0.01.
    end_bracket = 0.01;
    try
        % Save initial sign.
        initial_sign = sign(g(end_bracket));
		% While sign does not change or t exceeds maximum set value.
        while sign(g(end_bracket)) == initial_sign
            end_bracket = end_bracket + 0.01;
            if (end_bracket > 5)
				t = -1;
				intersection = [];
				return
            end
		end
		% Get root.
		t = fzero(g, [end_bracket - 0.05, end_bracket]);
		% Get intersection.
		intersection = ray_in(t);
	catch
		t = -1;
		intersection = [];
		return
	end
end