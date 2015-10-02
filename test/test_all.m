dbstop if error;

test_yaml;
test_general2str;
test_struct_stuff;
test_horzcat_all;
test_integration;
test_contiguous;
test_ros;
test_spatial_v2;
test_ode;

fprintf('All macro tests passed.\n');
