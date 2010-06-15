cmake_minimum_required(VERSION 2.6)
project(protobuf)

set (PROTOBUF_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set (PROTOBUF_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})

if (NOT WIN32)
 OPTION(BUILD_SHARED_LIBS "Build shard protobuf library" ON)
endif (NOT WIN32)

if (WIN32 AND BUILD_SHARED_LIBS)
 add_definitions(-DPROTOBUF_USE_DLLS)
endif (WIN32 AND BUILD_SHARED_LIBS)

# Direct all binary outputs to one directory
set(LIBRARY_OUTPUT_PATH    ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")
set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_BINARY_DIR}/bin CACHE INTERNAL "")

# Set up protobuf include directories, and the export file
set(PROTOBUF_INCLUDE_DIRS
  "${PROTOBUF_SOURCE_DIR}/src"
  "${PROTOBUF_BINARY_DIR}/src")
include_directories(${protobuf_INCLUDE_DIRS})
set(PROTOBUF_EXPORTS_FILE "${PROTOBUF_BINARY_DIR}/PROTOBUF_EXPORTS.cmake")
file(REMOVE "${PROTOBUF_EXPORTS_FILE}")

enable_testing()

INCLUDE (CheckFunctionExists)
INCLUDE (CheckIncludeFile)
INCLUDE (CheckIncludeFileCXX)
INCLUDE (CheckIncludeFiles)
INCLUDE (CheckLibraryExists)
INCLUDE (CheckSymbolExists)
INCLUDE (CheckTypeSize)

find_package(Threads)
set(THREAD_LINK_LIB "")
if (Threads_FOUND)
 set(HAVE_PTHREAD 1)
 set(THREAD_LINK_LIB ${CMAKE_THREAD_LIBS_INIT})
endif ()

# Enable classes using zlib compression
find_package(ZLIB)
set(ZLIB_LINK_LIB "")
if (ZLIB_FOUND)
 set(HAVE_ZLIB 1)
 set(ZLIB_LINK_LIB ${ZLIB_LIBRARIES})
endif (ZLIB_FOUND)

# A test framework used internally by protobuf
# protobuf test cases use this
add_subdirectory(gtest)

# Source code for protobuf and its test cases
add_subdirectory(src)

# Create the configure file for protobuf
configure_file("${PROTOBUF_SOURCE_DIR}/protobufConfig.cmake.in"
  "${PROTOBUF_BINARY_DIR}/protobufConfig.cmake" @ONLY)
