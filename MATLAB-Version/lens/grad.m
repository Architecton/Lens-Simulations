function [grad_val] = grad(f, T)
  %funkcija grad vrne gradient f v tocki T
  %f = f(x,y,z)
  %T = [x, y, z]
  %
  %gradient = [gradx, grady, gradz]
  
  only_x = @(f,yv, zv) @(x) f(x,yv,zv);   
  only_y = @(f,xv, zv) @(y) f(xv,y,zv);  
  only_z = @(f,xv, yv) @(z) f(xv,yv,z);
  fh1 = only_x(f, T(2), T(3));
  fh2 = only_y(f, T(1), T(3));
  fh3 = only_z(f, T(1), T(2));

  samples1 = fh1([T(1) - 10^(-3) ,T(1), T(1) + 10^(-3)]);
  samples2 = fh2([T(2) - 10^(-3) ,T(2), T(2) + 10^(-3)]);
  samples3 = fh3([T(3) - 10^(-3) ,T(3), T(3) + 10^(-3)]);
  
  grad_part_1 = gradient(samples1);
  grad_part_2 = gradient(samples2);
  grad_part_3 = gradient(samples3);
 
  grad_val = [grad_part_1(2), grad_part_2(2), grad_part_3(2)];
  
end