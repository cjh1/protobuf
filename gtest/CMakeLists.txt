cmake_minimum_required(VERSION 2.8)
project(gtest)

INCLUDE(${CMAKE_CURRENT_SOURCE_DIR}/CMake/gtest_macros.cmake)

include_directories(
 ${CMAKE_CURRENT_SOURCE_DIR}
 ${CMAKE_CURRENT_SOURCE_DIR}/include)
link_directories(${CMAKE_CURRENT_BINARY_DIR})

# gtest library
add_library(gtest
            src/gtest.cc
            src/gtest-death-test.cc
            src/gtest-filepath.cc
            src/gtest-port.cc
            src/gtest-test-part.cc
            src/gtest-typed-test.cc)
set_target_properties(gtest           PROPERTIES
                      CMAKE_CXX_FLAGS "${PTHREAD_CXX_FLAG}"
                      LINK_FLAGS      "${PTHREAD_LINK_FLAG}")
target_link_libraries(gtest "${PTHREAD_LINK_LIB}")

# gtest_main library
add_library(gtest_main src/gtest_main.cc)
set_target_properties(gtest_main     PROPERTIES
                      CMAKE_CXX_FLAGS "${PTHREAD_CXX_FLAG}"
                      LINK_FLAGS      "${PTHREAD_LINK_FLAG}")
target_link_libraries(gtest_main gtest "${PTHREAD_LINK_LIB}")

add_subdirectory(samples)
add_subdirectory(test)
