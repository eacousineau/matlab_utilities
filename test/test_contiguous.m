%> @brief Unittest for testing behaior of contiguous indices
%> @author Eric Cousineau <eacousineau@gmail.com>, member in Dr. Ames's
%> AMBER Lab
addpath('../matlab');
addpath_matlab_utilities('general', 'yaml');

yaml_cmp = @(a, b) strcmp(yaml_dump(a), yaml_dump(b));

%% Comparison

B = logical([0, 1, 1, 1, 0, 0, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1]);
C_expected = {[2, 3, 4], 8, [11, 12, 13], 16};
C_actual = contiguous_indices(B);
assert(yaml_cmp(C_actual, C_expected));

%% 
B = logical([1, 1, 0, 1, 1]);
C_expected = {[1, 2], [4, 5]};
C_actual = contiguous_indices(B);
assert(yaml_cmp(C_actual, C_expected));

%%
indices = [1, 5, 10];
len = 15;
C_expected = {[], 1:4, 5:9, 10:15};
C_actual = split_indices(len, indices);
assert(yaml_cmp(C_actual, C_expected));

%%
X = [0.2, 0.3, 0.55, 0.9, 1.2, 2.1];
xi = [0.22, 0.6];
x_expected = {0.2, [0.3, 0.55], [0.9, 1.2, 2.1]};
[C_actual, x_actual] = split_data(X, xi);

assert(yaml_cmp(x_actual, x_expected));
