# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.29

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.29.3/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.29.3/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build

# Include any dependencies generated for this target.
include examples/CMakeFiles/robust_curve_fitting.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/CMakeFiles/robust_curve_fitting.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/robust_curve_fitting.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/robust_curve_fitting.dir/flags.make

examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o: examples/CMakeFiles/robust_curve_fitting.dir/flags.make
examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o: /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/robust_curve_fitting.cc
examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o: examples/CMakeFiles/robust_curve_fitting.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o -MF CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o.d -o CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o -c /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/robust_curve_fitting.cc

examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.i"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/robust_curve_fitting.cc > CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.i

examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.s"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/robust_curve_fitting.cc -o CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.s

# Object files for target robust_curve_fitting
robust_curve_fitting_OBJECTS = \
"CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o"

# External object files for target robust_curve_fitting
robust_curve_fitting_EXTERNAL_OBJECTS =

bin/robust_curve_fitting: examples/CMakeFiles/robust_curve_fitting.dir/robust_curve_fitting.cc.o
bin/robust_curve_fitting: examples/CMakeFiles/robust_curve_fitting.dir/build.make
bin/robust_curve_fitting: lib/libceres.a
bin/robust_curve_fitting: /usr/local/lib/libglog.0.6.0.dylib
bin/robust_curve_fitting: /usr/local/lib/libgflags.2.2.2.dylib
bin/robust_curve_fitting: examples/CMakeFiles/robust_curve_fitting.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/robust_curve_fitting"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/robust_curve_fitting.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/robust_curve_fitting.dir/build: bin/robust_curve_fitting
.PHONY : examples/CMakeFiles/robust_curve_fitting.dir/build

examples/CMakeFiles/robust_curve_fitting.dir/clean:
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && $(CMAKE_COMMAND) -P CMakeFiles/robust_curve_fitting.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/robust_curve_fitting.dir/clean

examples/CMakeFiles/robust_curve_fitting.dir/depend:
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples/CMakeFiles/robust_curve_fitting.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/CMakeFiles/robust_curve_fitting.dir/depend

