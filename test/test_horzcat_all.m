%> @brief Test functinoality of horzcat_fields, horzcat_domains
%> @author Eric Cousineau <eacousineau@gmail.com>, member of Dr. Aaron
%> Ames's AMBER Lab 
%> @todo Use some yaml_cmp or something of that sort to compare
close('all'); clear('all'); path(pathdef());

% Setup
addpath('../matlab');
addpath_matlab_utilities('sim');

cellexpand = @(x) x{:};
numexpand = @(x) cellexpand(num2cell(x));

%% horzcat_fields
blank = struct('a', [], 'b', [], 'c', []);
actual = repmat(blank, 1, 3);
[actual.a] = numexpand([1, 2, 3]);
% [actual.b] = cellexpand({[5;6;7], [8;9;10], [11;12;13]});
actual(1).b = [5; 6; 7];
actual(2).b = [8; 9; 10];
actual(3).b = [11; 12; 13];
[actual.c] = cellexpand({'A', 'B', 'C'});

expected = struct('a', {[actual.a]}, 'b', {[actual.b]}, 'c', {[actual.c]})
actual = horzcat_fields(actual)

%% horzcat_domains - horizontal concatenate, removing last element for domains 1..n-1

% Basic arrays
d1 = 0:10;
d2 = 10:20;
d3 = 20:30;
actual = horzcat_domains(d1, d2, d3);
expected = 0:30;
assert(all(actual == expected));

% Vectors
d1 = ones(3, 5);
d2 = 2 * d1;
d3 = 3 * d1;
expected = [ones(3, 4), 2 * ones(3, 4), 3 * ones(3, 5)];
actual = horzcat_domains(d1, d2, d3);
flatten = @(x) x(:);
assert(all(flatten(actual == expected)));

% Struct arrays
s1 = struct('a', num2cell(d1, 1));
s2 = struct('a', num2cell(d2, 1));
s3 = struct('a', num2cell(d3, 1));
expected = struct('a', [num2cell(d1(:, 1:end-1), 1), num2cell(d2(:, 1:end-1), 1), ...
    num2cell(d3, 1)])
actual = horzcat_domains(s1, s2, s3)


%% horzcat_fields_domains
s1 = struct('a', 0:10, 'b', d1);
s2 = struct('a', 10:20, 'b', d2);
s3 = struct('a', 20:30, 'b', d3);
d_expected = horzcat_domains(d1, d2, d3);
expected = struct('a', 0:30, 'b', d_expected)
actual = horzcat_fields_domains([s1, s2, s3])

%> @todo Automate
fprintf('Please manually check that the data match\n');
