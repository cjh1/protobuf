cmake_minimum_required(VERSION 2.8)
project(protobuf)

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

set(PTHREAD_CXX_FLAG  "")
set(PTHREAD_LINK_FLAG "")
set(PTHREAD_LINK_LIB  "")
if (NOT WIN32)
 # If both pthread.h and pthread library file are found
 CHECK_INCLUDE_FILE("pthread.h" HAVE_PTHREAD_H)
 CHECK_LIBRARY_EXISTS("pthread" pthread_exit ""  HAVE_PTHREAD_LIB)
 # Then define HAVE_PTHREAD
 if (DEFINED HAVE_PTHREAD_H AND DEFINED HAVE_PTHREAD_LIB)
  set(HAVE_PTHREAD 1)
  set(PTHREAD_CXX_FLAG  "-pthread")
  set(PTHREAD_LINK_FLAG "-pthread")
  set(PTHREAD_LINK_LIB  "pthread")
 endif()
endif()

# Enable classes using zlib compression
find_package(ZLIB)
set(ZLIB_LINK_LIB "")
if (ZLIB_FOUND)
 set(HAVE_ZLIB 1)
 set(ZLIB_LINK_LIB "z")
endif ()

# A test framework used internally by protobuf
# protobuf test cases use this
add_subdirectory(gtest)

# Source code for protobuf and its test cases
add_subdirectory(src)
