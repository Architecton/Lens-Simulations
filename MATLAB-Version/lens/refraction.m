% function w = refraction(intersection, in_dir_vect, n1, n2, lens_equation, first)
% 
% Get new directional vector as ray crosses boundary between media.
%
% intersection ... point of intersection
% in_dir_vect ... directional vector of the ray
% n1 ... first refraction index
% n2 ... second refraction index
% lens_equation ... implicit equation of the lens
% first ... If equal to 1, the ray is entering the lens. If equal to 0, the
% ray is leaving the lens.
function w = refraction(intersection, in_dir_vect, n1, n2, lens_equation, first)
    
	% Get normal vector.
	n = grad(lens_equation, intersection)';
	
    % Normalise vectors.
    in_dir_vect = in_dir_vect/norm(in_dir_vect);
    n = n/norm(n);
	
	% Use Snell's law in vector form to compute new directional vector.
	if first
        w = (n1/n2).*(cross(n, cross(-n,in_dir_vect)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(n,in_dir_vect), cross(n,in_dir_vect))));
    else
        w = (n1/n2).*(cross(n, cross(n,in_dir_vect)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(-n,in_dir_vect), cross(n,in_dir_vect))));
	end
	
	clear intersection in_dir_vect n1 n2 lens_equation first;
end