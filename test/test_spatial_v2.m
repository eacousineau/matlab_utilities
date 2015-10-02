%> @brief Basic spatial_v2 unittests
% function [] = test_spatial_v2()
close('all'); clear('all'); path(pathdef());

% Setup
addpath('../matlab');
addpath_matlab_utilities('spatial_v2');

maxabs = @(x) max(abs(x(:)));
tolerance = 1e-8;

%> @note IMPORTANT! rx(), ry(), and rz() in spatial_v2 give the transpose
%> of what would be considered a 'usual rotation matrix' because of the
%> frames that are considered

[X, S] = jcalc('-Rz', pi / 2);
Rz_usual = @(q) [
    cos(q), -sin(q), 0;
    sin(q), cos(q), 0;
    0, 0, 1;
    ];
E = Rz_usual(-pi / 2)';
X_expected = blkdiag(E, E);
S_expected = [0; 0; -1; 0; 0; 0];
assert(maxabs(X - X_expected) < tolerance);
assert(maxabs(S - S_expected) < tolerance);

% model = struct();

% end
