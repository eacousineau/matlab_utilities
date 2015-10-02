function [] = test_ode_event()

addpath('../matlab');
addpath_matlab_utilities('ode');

close('all');

%% Basic time varying sinusoid integration
% Go fer it
T = 1;
w = 2 * pi / T;
x_func = @(t, x) sin(w * t);

    function [dx, event, calc] = dx_func(t, x, ts_prev, xs_prev, calcs_prev)
        dx = w * cos(w * t);
        if type == 1
            event = t >= n_event * T;
        elseif type == 2
            event = (t >= n_event * T) & dx < 0;
        else
            error('Invalid type: %d', type);
        end
        calc = [];
    end

x0 = x_func(0);
n = 5;
n_event = 2;
tf = n * T;

% type: {1: Trigger after n_event periods, 2: Trigger after n_event periods
% and the velocity is negative}
for type = 1:2
    ts = linspace(0, tf);
    [ts_int, xs_int, calcs] = ode4_event(@dx_func, ts, x0);

    % Truncate analytical solution
    ts = ts_int;
    xs = x_func(ts, x0);

    figure();
    plot_compare('sin', ts, 'Actual', xs, 'Integrated', xs_int, '[Integration] ');

    tol = 1e-5;
    maxabs = @(x) max(abs(x(:)));
    diff = xs - xs_int;
    assert(maxabs(diff) < tol);
end

end
