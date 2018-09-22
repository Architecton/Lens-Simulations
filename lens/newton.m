% function t = newton(g, t0, tol, max_it)
%
% Find root of function given by function handle g using the Newton-Raphson
% method
%
% g ... function handle
% t0 ... initial value for t
% tol ... tolerance for declaring convergence
% max_it ... maximum number of iterations to perform
function t = newton(g, t0, tol, max_it)
	% numeric derivative
	dg = @(t) gradient([g(t - 10.^(-4)), g(t), g(t + 10.^(-4))], 10.^(-4));
	% Set t to initial value.
	t = t0;
	
	% Perform the Newton-Raphson method
	for it = 1:max_it
		t_prev = t;
		val_dg = dg(t);
		t = t - g(t) / val_dg(2);
		if abs(t - t_prev) < tol
			break;
		end
	end
	clear g dg;
end