# Install script for directory: /Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/objdump")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/internal/ceres/cmake_install.cmake")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for the subdirectory.
  include("/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/examples/cmake_install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/ceres" TYPE FILE FILES
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/autodiff_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/autodiff_first_order_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/autodiff_manifold.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/c_api.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/ceres.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/conditioned_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/constants.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/context.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/cost_function_to_functor.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/covariance.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/crs_matrix.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/cubic_interpolation.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/dynamic_autodiff_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/dynamic_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/dynamic_cost_function_to_functor.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/dynamic_numeric_diff_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/evaluation_callback.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/first_order_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/gradient_checker.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/gradient_problem.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/gradient_problem_solver.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/iteration_callback.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/jet.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/jet_fwd.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/line_manifold.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/loss_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/manifold.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/manifold_test_utils.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/normal_prior.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/numeric_diff_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/numeric_diff_first_order_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/numeric_diff_options.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/ordered_groups.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/problem.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/product_manifold.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/rotation.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/sized_cost_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/solver.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/sphere_manifold.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/tiny_solver.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/tiny_solver_autodiff_function.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/tiny_solver_cost_function_adapter.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/types.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/version.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/ceres/internal" TYPE FILE FILES
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/array_selector.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/autodiff.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/disable_warnings.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/eigen.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/euler_angles.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/fixed_array.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/householder_vector.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/integer_sequence_algorithm.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/jet_traits.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/line_parameterization.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/memory.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/numeric_diff.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/parameter_dims.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/port.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/reenable_warnings.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/sphere_manifold_functions.h"
    "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/include/ceres/internal/variadic_evaluate.h"
    )
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/include/")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres/CeresTargets.cmake")
    file(DIFFERENT _cmake_export_file_changed FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres/CeresTargets.cmake"
         "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles/Export/9a3bb6344a10c987f9c537d2a0e39364/CeresTargets.cmake")
    if(_cmake_export_file_changed)
      file(GLOB _cmake_old_config_files "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres/CeresTargets-*.cmake")
      if(_cmake_old_config_files)
        string(REPLACE ";" ", " _cmake_old_config_files_text "${_cmake_old_config_files}")
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres/CeresTargets.cmake\" will be replaced.  Removing files [${_cmake_old_config_files_text}].")
        unset(_cmake_old_config_files_text)
        file(REMOVE ${_cmake_old_config_files})
      endif()
      unset(_cmake_old_config_files)
    endif()
    unset(_cmake_export_file_changed)
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres" TYPE FILE FILES "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles/Export/9a3bb6344a10c987f9c537d2a0e39364/CeresTargets.cmake")
  if(CMAKE_INSTALL_CONFIG_NAME MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres" TYPE FILE FILES "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CMakeFiles/Export/9a3bb6344a10c987f9c537d2a0e39364/CeresTargets-release.cmake")
  endif()
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres" TYPE FILE RENAME "CeresConfig.cmake" FILES "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CeresConfig-install.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT STREQUAL "Unspecified" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/cmake/Ceres" TYPE FILE FILES "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/CeresConfigVersion.cmake")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/Users/Keaton/Documents/econ_projects/grf-EUT/core/third_party/ceres-solver-master/my_ceres_build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
