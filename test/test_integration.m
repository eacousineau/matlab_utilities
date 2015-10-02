%> @brief Unittest for basic integration test
%> @author Eric Cousineau <eacousineau@gmail.com>, part of Dr. Ames's AMBER Lab
close('all'); clear('all'); path(pathdef());

addpath('../matlab');
addpath_matlab_utilities('validation');

T = 2 * pi;
n = 20;
tf = n * T;
w = 2 * pi / T;
%> @note Have to increase resolution to minimize error
count = 5000;
ts = linspace(0, tf, count);

xs = sin(w * ts);
dxs = cos(w * ts);

tol = 1e-4;
maxabs = @(x) max(abs(x(:)));

xs_int = integration_check(ts, xs, dxs, 'sin');
diff = xs - xs_int;

assert(maxabs(diff) < tol);
