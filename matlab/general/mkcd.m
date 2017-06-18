function [owd] = mkcd(p)
%
if ~isdir(p)
    mkdir(p);
end
owd = cd(p);

end
