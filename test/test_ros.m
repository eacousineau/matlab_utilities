%> @brief Basic ros unittests
close('all'); clear('all'); path(pathdef());

% Setup
use_ros_setup = false;
if use_ros_setup
    %> @note An alternative method to finding matlab_utilites
    %> Not entirely suggested due to distributed nature of versioning
    [~, pkg] = system('rospack find matlab_utilities');
    addpath(fullfile(strtrim(pkg), 'matlab'));
else
    addpath('../matlab');
end
addpath_matlab_utilities('ros');

% Testing
actual = ros_resolve_local_url('package://roscpp');
expected = rospack_find('roscpp');
assert(strcmp(actual, expected));

actual = ros_resolve_local_url('package://roscpp/package.xml');
expected = fullfile(rospack_find('roscpp'), 'package.xml');
assert(strcmp(actual, expected));

fprintf('All tests passed.\n');
