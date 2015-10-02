%> @author Eric Couisneau <eacousineau@gmail.com>, AMBER Lab, under Dr.
%> Aaron Ames
function [] = general2str_prototype()

addpath('../matlab');
addpath_matlab_utilities('general');

str = 'a\nb\nc';
fprintf(indent(str, '\t\t'));
fprintf('\n\n');

c = {'1', 2, 3.5, 'abc'};
fprintf(cell2str(c));
fprintf('\n\n');

s = struct();
s.name = 'billy';
s.A = rand(5, 3);
s.c = c;
s.sub = struct('x', 10, 'y', [1, 2, 3]);
str = general2str(s);
fprintf(str);
fprintf('\n\n');

end
