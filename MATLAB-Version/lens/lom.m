function w = refraction(intersection, in_dir_vect, n1, n2, leca, first)
    % funkcija lom vrne vektor, ki se zlomi ko naleti na leco
    % intersection = [x, y, z] ... tocka, kjer vektor in_dir_vect seka leco
    % in_dir_vect = [x,y,z] ... vhodni vektor
    % n1 ... 1. lomni kolicnik (iz snovi)
    % n2 ... 2. lomni kolicnik (in_dir_vect snov) 
    % leca ... enacba lece f(x,y,z)
    %
    % vrne nov vektor, ki se lomi po lomnem zakonu
    % feval(leca,intersection(1), intersection(2), intersection(3))
    n = grad(leca, intersection)'; %normala na ploskev in_dir_vect tocki intersection
        
    %lomni zakon in_dir_vect vektorski obliki
    in_dir_vect = in_dir_vect/norm(in_dir_vect);
    n = n/norm(n);
    if first
        w = (n1/n2).*(cross(n, cross(-n,in_dir_vect)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(n,in_dir_vect), cross(n,in_dir_vect))));
    else
        w = (n1/n2).*(cross(n, cross(n,in_dir_vect)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(-n,in_dir_vect), cross(n,in_dir_vect))));
	end
	clear intersection in_dir_vect n1 n2 leca first;
end