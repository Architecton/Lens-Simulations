function t = newton(g, t0, tol, max_it)
	dg = @(t) gradient([g(t - 10.^(-4)), g(t), g(t + 10.^(-4))], 10.^(-4));
	t = t0;
	for it = 1:max_it
		t_prev = t;
		val_dg = dg(t);
		t = t - g(t) / val_dg(2);
		if abs(t - t_prev) < tol
			break;
		end
	end
end