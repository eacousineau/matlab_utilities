%> @brief Basic ros unittests
close('all'); clear('all'); path(pathdef());

% Setup
% [~, pkg] = system('rospack find matlab_utilities');
% pkg = strtrim(pkg);
addpath(fullfile('..', 'matlab'));
addpath_matlab_utilities('general', 'yaml');

% Use common basis for comparison
yaml_cmp = @(a, b) strcmp(yaml_dump(a), yaml_dump(b));
seval = @(x) eval(sprintf(x));
maxabs = @(x) max(abs(x(:)));

tol = 1e-5;
precision = 20;

%% Arrays
A = rand(5);
str = array2str(A, precision);
assert(strcmp(str, general2str(A, precision)));
A_actual = seval(str);
assert(maxabs(A - A_actual) < tol);

%% Strings (basic)
s = 'abc';
expected = '''abc''';
actual = general2str(s);
assert(strcmp(expected, actual));

%% Cells
C = {'a', 'bc', 1, [1, 2, 3], {'a', 'b', 'D'}};
str = cell2str(C);
assert(strcmp(str, general2str(C, precision)));
C_actual = seval(str);
assert(yaml_cmp(C, C_actual));

%% Structs
s = struct();
s.name = 'billy';
s.A = A;
s.C = C;
s.sub = struct('x', 10, 'y', [1, 2, 3]);
 % Use high precision so YAML does not truncate
str = struct2str(s, precision);
assert(strcmp(str, general2str(s, precision)));
s_actual = seval(str);
assert(yaml_cmp(s, s_actual));

%% Done
fprintf('All tests passed\n');
