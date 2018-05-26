% function [grad_val] = grad(f, T)
%
% Get value of gradient of function represented by function handle f at
% point T.
%
% f ... function handle representing an implicit function
% T ... point at which to evaluate the gradient
function [grad_val] = grad(f, T)
  
	% Extract functions where other two independent variables are constant.
	only_x = @(f,yv, zv) @(x) f(x,yv,zv);   
	only_y = @(f,xv, zv) @(y) f(xv,y,zv);  
	only_z = @(f,xv, yv) @(z) f(xv,yv,z);
	% Make function handle with given values for T.
	fh1 = only_x(f, T(2), T(3));
	fh2 = only_y(f, T(1), T(3));
	fh3 = only_z(f, T(1), T(2));

	% Gather sample value around T
	samples1 = fh1([T(1) - 10^(-3) ,T(1), T(1) + 10^(-3)]);
	samples2 = fh2([T(2) - 10^(-3) ,T(2), T(2) + 10^(-3)]);
	samples3 = fh3([T(3) - 10^(-3) ,T(3), T(3) + 10^(-3)]);

	% Compute partial derivatives.
	grad_part_1 = gradient(samples1);
	grad_part_2 = gradient(samples2);
	grad_part_3 = gradient(samples3);

	% Make vector representing the evaluated gradient.
	grad_val = [grad_part_1(2), grad_part_2(2), grad_part_3(2)];
  
end