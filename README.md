# matlab_utilities

## Purpose

Collection of general MATLAB scripts.

## Usage

To use the dependencies in here, simply make sure that the `matlab` direcotry is in your Matlab `path()`, figure out which dependencies you want (i.e., `general`, `sim`, `yaml`, etc.), and execute something like:

	addpath_matlab_utilities('general', 'sim', 'yaml', 'ros');

## Using as ROS Package

If you are incorporating `matlab_utilities` as a bonafide ROS package, do the following to add it to your `path()` (this example loads `general` and `yaml`):

	% Load dependencies
	[~, pkg] = system('rospack find matlab_utilities');
	pkg = strtrim(pkg);
	addpath(fullfile(pkg, 'matlab'));
	addpath_matlab_utilities('yaml', 'ros');
