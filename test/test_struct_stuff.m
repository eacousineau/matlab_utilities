%> @brief Test functinoality of horzcat_fields, horzcat_domains, and
close('all'); clear('all'); path(pathdef());

% Setup
addpath('../matlab');
addpath_matlab_utilities('general', 'yaml');

% Use yaml to project into a common comparison basis
% (read: I'm lazy)
yaml_cmp = @(a, b) strcmp(yaml_dump(a), yaml_dump(b));

% Load expected data
tests = yaml_read_file('test_struct_stuff.yaml');

%% struct_overlay
test = tests.struct_overlay;
input = test.in;
expected = test.out;

default = struct('name', 'Bill', 'age', 25, 'account', 2058, ...
    'sub_struct', struct('published_paper', false, 'has_data', false));

in = struct('name', 'Timmy', 'age', 18, ...
    'sub_struct', struct('published_paper', true));

% Make sure we're sane with our inputs when we're testing output
assert(yaml_cmp(default, input.default));
assert(yaml_cmp(in, input.in));


% Test default overlay
opts = struct_overlay(default, in);
assert(yaml_cmp(opts, expected.opts));

% Test nonrecursive (will obliterate extra options in sub_struct)
opts_nonrecursive = struct_overlay(default, in, {'Recursive', false});
assert(yaml_cmp(opts_nonrecursive, expected.opts_nonrecursive));

% Test adding new fields
in_new = in;
in_new.new_field = 42;

assert(yaml_cmp(in_new, input.in_new));

% Ensure that it throws an error if 'AllowNew' is not enabled
threw = false;
try
    % Will throw an erorr because a new field is introduced
    struct_overlay(default, in_new);
catch e
    % @todo Check for a specific error?
    threw = true;
end
assert(threw);

% Now check output
opts_new = struct_overlay(default, in_new, {'AllowNew', true});
assert(yaml_cmp(opts_new, expected.opts_new));

%% struct_permute
test = tests.struct_permute;
input = test.in;
expected = test.out;

opt_values = struct('mass', {{5, 10, 15}}, 'pos', {{1, 2}}, 'extra', struct('x', {{2, 3}}));
opt_set = struct_permute(opt_values);

assert(yaml_cmp(opt_values, input.opt_values));
% @todo Is having yaml convert to struct array dumb? Yes...
assert(yaml_cmp(opt_set, expected.opt_set));

%> @todo Automate
fprintf('All tests passed\n');
