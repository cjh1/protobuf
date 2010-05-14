cmake_minimum_required(VERSION 2.8)
project(protobuf)

set(LIBRARY_OUTPUT_PATH    ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")

enable_testing()

add_subdirectory(gtest)
add_subdirectory(src)
