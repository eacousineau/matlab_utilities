function [] = array2str_prototype()

addpath('../matlab');
addpath_matlab_utilities('general');

A = rand(10);
s = size(A);
raw = arrayfun(@num2str, A, 'UniformOutput', false);
rows = cell(s(1), 1);
for i = 1:size(A, 1)
    rows{i} = implode(raw(i, :), ', ');
end
str = ['[\n', implode(rows, ';\n'), ';\n]'];
fprintf(str);

end
