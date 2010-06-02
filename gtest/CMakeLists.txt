cmake_minimum_required(VERSION 2.6)
project(gtest)

INCLUDE(${CMAKE_CURRENT_SOURCE_DIR}/CMake/gtest_macros.cmake)

include_directories(
 ${CMAKE_CURRENT_SOURCE_DIR}
 ${CMAKE_CURRENT_SOURCE_DIR}/include)
link_directories(${CMAKE_CURRENT_BINARY_DIR})

# gtest library
set(GTEST_SOURCES
    src/gtest.cc
    src/gtest-death-test.cc
    src/gtest-filepath.cc
    src/gtest-port.cc
    src/gtest-test-part.cc
    src/gtest-typed-test.cc)
if (WIN32)
 # Always build static library on Windows
 # because gtest does not export any symbol in its source
 add_library(gtest STATIC ${GTEST_SOURCES})
else (WIN32)
 add_library(gtest ${GTEST_SOURCES})
endif (WIN32)
target_link_libraries(gtest "${THREAD_LINK_LIB}")

# gtest_main library
if (WIN32)
 add_library(gtest_main STATIC src/gtest_main.cc)
else (WIN32)
 add_library(gtest_main src/gtest_main.cc)
endif (WIN32)
target_link_libraries(gtest_main gtest "${THREAD_LINK_LIB}")

add_subdirectory(samples)
add_subdirectory(test)
