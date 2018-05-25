function w = lom(T, v, n1, n2, leca, first)
    %funkcija lom vrne vektor, ki se zlomi ko naleti na leco
    %T = [x, y, z] ... tocka, kjer vektor v seka leco
    %v = [x,y,z] ... vhodni vektor
    %n1 ... 1. lomni kolicnik (iz snovi)
    %n2 ... 2. lomni kolicnik (v snov) 
    %leca ... enacba lece f(x,y,z)
    %
    %vrne nov vektor, ki se lomi po lomnem zakonu
    %  feval(leca,T(1), T(2), T(3))
    n = grad(leca, T)'; %normala na ploskev v tocki T
    
    % Optional code used for plotting 
    %normal = @(t) T' + t.*n;
    %plot_ray(normal , 5, 'y');	
    
    
    %lomni zakon v vektorski obliki
    v = v/norm(v);
    n = n/norm(n);
    if first
        w = (n1/n2).*(cross(n, cross(-n,v)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(n,v), cross(n,v))));
    else
        w = (n1/n2).*(cross(n, cross(n,v)))-n.*sqrt(1-(((n1/n2).^2) .* dot(cross(n,v), cross(n,v))));
    end
end