function [] = test_ode()

addpath('../matlab');
addpath_matlab_utilities('validation', 'ode', 'yaml');

%% Basic time varying sinusoid integration
% Go fer it
T = 1;
w = 2 * pi / T;
x_func = @(t, x) sin(w * t);
dx_func = @(t, x) w * cos(w * t);

x0 = x_func(0);
tf = 5 * T;
ts = linspace(0, tf);

xs = x_func(ts, x0);
xs_int = ode4(dx_func, ts, x0);

figure();
plot_compare('sin', ts, 'Actual', xs, 'Integrated', xs_int, '[Integration] ');

tol = 1e-5;
maxabs = @(x) max(abs(x(:)));
diff = xs - xs_int;
assert(maxabs(diff) < tol);

%% Add a simple ODE: Seconder Order Spring-Mass-Damper
m = 1;
c = 1;
k = 100;
wn = sqrt(k / m);
zeta = c / (2 * sqrt(k * m));
wd = wn * sqrt(1 - zeta^2);

T = 2 * pi / wd;
n = 10;
count = 1000;

tf = n * T;
ts = linspace(0, tf, count);
% Initial condition
x0 = 2;
dx0 = 1;

% Second Order to First Order: v = [x; dx]
v0 = [x0; dx0];

% Position Coefficients
c1 = x0;
c2 = 1 / wd * (dx0 + zeta * wn * c1);
% Velocity Coefficients
d1 = (-zeta * wn * c1) + c2 * wd;
d2 = (-zeta * wn * c2) - c1 * wd;
% Analytical Solution
v_solution = @(t) [
    exp(-zeta * wn * t) .* (c1 * cos(wd * t) + c2 * sin(wd * t));
    exp(-zeta * wn * t) .* (d1 * cos(wd * t) + d2 * sin(wd * t));
    ];

dv_func = @(t, v) [
    v(2);
    1 / m * (-k * v(1) -c * v(2));
    ];

maxabs = @(x) max(abs(x(:)));

vs = v_solution(ts);
% Test each different integrator
funcs = {'ode1', 'ode_taylor_second', 'ode4'};
nfunc = length(funcs);
entries = cell(1, nfunc);
entry = struct('func', [], 'err_max', [], 'err_mean', []);
for i = 1:length(funcs)
    func = funcs{i};
    vs_int = feval(func, dv_func, ts, v0);
    
    err = vs - vs_int;
    entry.func = func;
    entry.err_max = maxabs(err);
    entry.err_mean = mean(abs(err), 2);
    entries{i} = entry;
end

fprintf(yaml_dump(struct('results', {entries})));

figure();
plot_compare('Spring Mass Damper', ts, 'Actual', vs, 'Integrated', vs_int, '[Integration] ');

diff = maxabs(vs - vs_int);
tol = 1e-4;
assert(maxabs(diff) < tol);

fprintf('All tests passed.\n');

end
