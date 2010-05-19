cmake_minimum_required(VERSION 2.8)
project(protobuf)

OPTION(BUILD_SHARED_LIBS "Build shard protobuf library" ON)

# Direct all binary outputs to one directory
set(LIBRARY_OUTPUT_PATH    ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")

enable_testing()

INCLUDE (CheckFunctionExists)
INCLUDE (CheckIncludeFile)
INCLUDE (CheckIncludeFileCXX)
INCLUDE (CheckIncludeFiles)
INCLUDE (CheckLibraryExists)
INCLUDE (CheckSymbolExists)
INCLUDE (CheckTypeSize)

find_package(Threads)
if (Threads_FOUND)
 set(HAVE_PTHREAD 1)
endif ()

# Enable classes using zlib compression
find_package(ZLIB)
if (ZLIB_FOUND)
 set(HAVE_ZLIB 1)
endif ()

# A test framework used internally by protobuf
# protobuf test cases use this
add_subdirectory(gtest)

# Source code for protobuf and its test cases
add_subdirectory(src)
