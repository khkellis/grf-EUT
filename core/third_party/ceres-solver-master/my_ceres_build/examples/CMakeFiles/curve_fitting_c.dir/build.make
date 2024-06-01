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
include examples/CMakeFiles/curve_fitting_c.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include examples/CMakeFiles/curve_fitting_c.dir/compiler_depend.make

# Include the progress variables for this target.
include examples/CMakeFiles/curve_fitting_c.dir/progress.make

# Include the compile flags for this target's objects.
include examples/CMakeFiles/curve_fitting_c.dir/flags.make

examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o: examples/CMakeFiles/curve_fitting_c.dir/flags.make
examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o: /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/curve_fitting.c
examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o: examples/CMakeFiles/curve_fitting_c.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o -MF CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o.d -o CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o -c /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/curve_fitting.c

examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/curve_fitting_c.dir/curve_fitting.c.i"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/curve_fitting.c > CMakeFiles/curve_fitting_c.dir/curve_fitting.c.i

examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/curve_fitting_c.dir/curve_fitting.c.s"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/cc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples/curve_fitting.c -o CMakeFiles/curve_fitting_c.dir/curve_fitting.c.s

# Object files for target curve_fitting_c
curve_fitting_c_OBJECTS = \
"CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o"

# External object files for target curve_fitting_c
curve_fitting_c_EXTERNAL_OBJECTS =

bin/curve_fitting_c: examples/CMakeFiles/curve_fitting_c.dir/curve_fitting.c.o
bin/curve_fitting_c: examples/CMakeFiles/curve_fitting_c.dir/build.make
bin/curve_fitting_c: lib/libceres.a
bin/curve_fitting_c: /usr/local/lib/libglog.0.6.0.dylib
bin/curve_fitting_c: /usr/local/lib/libgflags.2.2.2.dylib
bin/curve_fitting_c: examples/CMakeFiles/curve_fitting_c.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../bin/curve_fitting_c"
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/curve_fitting_c.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
examples/CMakeFiles/curve_fitting_c.dir/build: bin/curve_fitting_c
.PHONY : examples/CMakeFiles/curve_fitting_c.dir/build

examples/CMakeFiles/curve_fitting_c.dir/clean:
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples && $(CMAKE_COMMAND) -P CMakeFiles/curve_fitting_c.dir/cmake_clean.cmake
.PHONY : examples/CMakeFiles/curve_fitting_c.dir/clean

examples/CMakeFiles/curve_fitting_c.dir/depend:
	cd /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/examples /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples/CMakeFiles/curve_fitting_c.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : examples/CMakeFiles/curve_fitting_c.dir/depend

