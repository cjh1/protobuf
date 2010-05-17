cmake_minimum_required(VERSION 2.8)
project(gtest)

INCLUDE(${CMAKE_CURRENT_SOURCE_DIR}/CMake/gtest_macros.cmake)

include_directories(
 ${CMAKE_CURRENT_SOURCE_DIR}
 ${CMAKE_CURRENT_SOURCE_DIR}/include)
link_directories(${CMAKE_CURRENT_BINARY_DIR})

# gtest library
add_library(gtest SHARED
            src/gtest.cc
            src/gtest-death-test.cc
            src/gtest-filepath.cc
            src/gtest-port.cc
            src/gtest-test-part.cc
            src/gtest-typed-test.cc)
set_target_properties(gtest           PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(gtest pthread)

# gtest_main library
add_library(gtest_main SHARED src/gtest_main.cc)
set_target_properties(gtest_main     PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(gtest_main gtest pthread)

add_subdirectory(samples)
add_subdirectory(test)
