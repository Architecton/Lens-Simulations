function gradient = grad(f, T)
  %funkcija grad vrne gradient f v tocki T
  %f = f(x,y,z)
  %T = [x, y, z]
  %
  %gradient = [gradx, grady, gradz]
  
  only_x = @(f,yv, zv) @(x) f(x,yv,zv);   
  only_y = @(f,xv, zv) @(y) f(xv,y,zv);  
  only_z = @(f,xv, yv) @(z) f(xv,yv,z);
  
  grad =@(f,x,y,z) [gradient(only_x(f,y,z),x),gradient(only_y(f,x,z),y),gradient(only_z(f,x,y),z)];
  gradient = grad(f, T(1), T(2), T(3));
  
endfunction