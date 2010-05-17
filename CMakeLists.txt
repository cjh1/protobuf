cmake_minimum_required(VERSION 2.8)
project(protobuf)

# Direct all binary outputs to one directory
set(LIBRARY_OUTPUT_PATH    ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")

enable_testing()

# A test framework used internally by protobuf
# protobuf test cases use this
add_subdirectory(gtest)

# Source code for protobuf and its test cases
add_subdirectory(src)
