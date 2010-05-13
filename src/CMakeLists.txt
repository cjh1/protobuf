cmake_minimum_required(VERSION 2.8)
project(protobuf)

# Include all the necessary files for macros
INCLUDE (CheckFunctionExists)
INCLUDE (CheckIncludeFile)
INCLUDE (CheckIncludeFileCXX)
INCLUDE (CheckIncludeFiles)
INCLUDE (CheckLibraryExists)
INCLUDE (CheckSymbolExists)
INCLUDE (CheckTypeSize)

set(PACKAGE           "protobuf")
set(VERSION           "2.3.0")
set(PACKAGE_BUGREPORT "protobuf@googlegroups.com")
set(PACKAGE_NAME      "Protocal Buffers")
set(PACKAGE_TARNAME   "protobuf")
set(PACKAGE_VERSION   "2.3.0")
set(PACKAGE_STRING    "Protocal Buffers 2.3.0")

CHECK_INCLUDE_FILE("dlfcn.h"     HAVE_DLFCN_H)
CHECK_INCLUDE_FILE("inttypes.h"  HAVE_INTTYPES_H)
CHECK_INCLUDE_FILE("memory.h"    HAVE_MEMORY_H)
CHECK_INCLUDE_FILE("stdint.h"    HAVE_STDINT_H)
CHECK_INCLUDE_FILE("stdlib.h"    HAVE_STDLIB_H)
CHECK_INCLUDE_FILE("strings.h"   HAVE_STRINGS_H)
CHECK_INCLUDE_FILE("string.h"    HAVE_STRING_H)
CHECK_INCLUDE_FILE("sys/stat.h"  HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILE("sys/types.h" HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILE("unistd.h"    HAVE_UNISTD_H)

# If both pthread.h and pthread library file are found
CHECK_INCLUDE_FILE("pthread.h" HAVE_PTHREAD_H)
CHECK_LIBRARY_EXISTS("pthread" pthread_exit ""  HAVE_PTHREAD_LIB)
# Then define HAVE_PTHREAD
if (DEFINED HAVE_PTHREAD_H AND DEFINED HAVE_PTHREAD_LIB)
 set(HAVE_PTHREAD 1)
endif()

# Enumerate all known and possible combinations of
# hash_map/hash_set header files location
# hash_map/hash_set namespace name and
# hash_map/hash_set class name
# Break on first successful compile and record names
set(NAMESPACE "")
set(LOCATION_MAP "")
set(CLASSNAME_MAP "")
set(LOCATION_SET "")
set(CLASSNAME_SET "")
foreach(NAMESPACE_I std std::tr1 stdext __gnu_cxx "")
 # Try hash_map
 foreach(LOCATION_MAP_I hash_map tr1/unordered_map ext/hash_map)
  foreach(CLASSNAME_MAP_I unordered_map hash_map)
   configure_file(${CMAKE_CURRENT_SOURCE_DIR}/CMake/hash_map_test.cc.in
                  ${CMAKE_CURRENT_BINARY_DIR}/CMake/hash_map_test.cc
                  @ONLY)
   try_compile(SUCCEED_MAP
               ${CMAKE_CURRENT_BINARY_DIR}/CMake
               ${CMAKE_CURRENT_BINARY_DIR}/CMake/hash_map_test.cc)
   if (SUCCEED_MAP)
    set(CLASSNAME_MAP "${CLASSNAME_MAP_I}")
    break()
   endif()
  endforeach(CLASSNAME_MAP_I)
  if (SUCCEED_MAP)
   set(LOCATION_MAP "${LOCATION_MAP_I}")
   break()
  endif()
 endforeach(LOCATION_MAP_I)

 # Try hash_set
 foreach(LOCATION_SET_I hash_set tr1/unordered_set ext/hash_set)
  foreach(CLASSNAME_SET_I unordered_set hash_set)
   configure_file(${CMAKE_CURRENT_SOURCE_DIR}/CMake/hash_set_test.cc.in
                  ${CMAKE_CURRENT_BINARY_DIR}/CMake/hash_set_test.cc
                  @ONLY)
   try_compile(SUCCEED_SET
               ${CMAKE_CURRENT_BINARY_DIR}/CMake
               ${CMAKE_CURRENT_BINARY_DIR}/CMake/hash_set_test.cc)
   if (SUCCEED_SET)
    set(CLASSNAME_SET "${CLASSNAME_SET_I}")
    break()
   endif()
  endforeach(CLASSNAME_SET_I)
  if (SUCCEED_SET)
   set(LOCATION_SET "${LOCATION_SET_I}")
   break()
  endif()
 endforeach(LOCATION_SET_I)

 # See if we found a successful compile
 if (SUCCEED_MAP AND SUCCEED_SET)
  # Namespace of hash_map/hash_set
  set(HASH_NAMESPACE "${NAMESPACE_I}")
  # Define if the compiler has hash_map
  set(HAVE_HASH_MAP 1)
  # Location of <hash_map> file
  set(HASH_MAP_H "${LOCATION_MAP}")
  # Class name of the <hash_map>
  set(HASH_MAP_CLASS "${CLASSNAME_MAP}")
  # Define if the compiler has hash_set
  set(HAVE_HASH_SET 1)
  # Location of <hash_set> file
  set(HASH_SET_H "${LOCATION_SET}")
  # Class name of <hash_set>
  set(HASH_SET_CLASS "${CLASSNAME_SET}")
  break()
 endif ()
endforeach(NAMESPACE_I)

# Enable classes using zlib compression
find_package(ZLIB)
if (ZLIB_FOUND)
 set(HAVE_ZLIB 1)
endif ()

# Define to the sub-directory in which libtool stores uninstalled libraries
# LT_OBJDIR

# Define to necessary symbol if this constant
# uses a non-standard name on your system
set(ATTR_NAME "UNKNOWN")
foreach(PTHREAD_TEST PTHREAD_CREATE_JOINABLE PTHREAD_CREATE_UNDETACHED)
 configure_file(${CMAKE_CURRENT_SOURCE_DIR}/CMake/pthread_test.cc.in
                ${CMAKE_CURRENT_BINARY_DIR}/CMake/pthread_test.cc
                @ONLY)
 try_compile(SUCCEED
             ${CMAKE_CURRENT_BINARY_DIR}/CMake
             ${CMAKE_CURRENT_BINARY_DIR}/CMake/pthread_test.cc)
 if (SUCCEED)
  set(ATTR_NAME "${PTHREAD_TEST}")
  break()
 endif ()
endforeach(PTHREAD_TEST)

if ("${ATTR_NAME}" STREQUAL "${PTHREAD_CREATE_JOINABLE}")
 set(PTHREAD_CREATE_JOINABLE "${ATTR_NAME}")
endif ()

# Define to 1 if you have the ANSI C header files
CHECK_INCLUDE_FILE("stddef.h" HAVE_STDDEF_H)
if (HAVE_STDLIB_H AND HAVE_STDDEF_H)
 set(STDC_HEADERS 1)
endif ()

# Config config.h.cmake.in
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/config.h)

# Targets
# 1 : libprotobuf
# 2 : libprotoc
# 3 : protoc

# Target 1
set(LIBPROTOBUF_SOURCES
 google/protobuf/stubs/common.cc
 google/protobuf/stubs/once.cc
 google/protobuf/stubs/hash.cc
 google/protobuf/stubs/hash.h
 google/protobuf/stubs/map-util.h
 google/protobuf/stubs/stl_util-inl.h
 google/protobuf/extension_set.cc
 google/protobuf/generated_message_util.cc
 google/protobuf/message_lite.cc
 google/protobuf/repeated_field.cc
 google/protobuf/wire_format_lite.cc
 google/protobuf/io/coded_stream.cc
 google/protobuf/io/coded_stream_inl.h
 google/protobuf/io/zero_copy_stream.cc
 google/protobuf/io/zero_copy_stream_impl_lite.cc
 google/protobuf/stubs/strutil.cc
 google/protobuf/stubs/strutil.h
 google/protobuf/stubs/substitute.cc
 google/protobuf/stubs/substitute.h
 google/protobuf/stubs/structurally_valid.cc
 google/protobuf/descriptor.cc
 google/protobuf/descriptor.pb.cc
 google/protobuf/descriptor_database.cc
 google/protobuf/dynamic_message.cc
 google/protobuf/extension_set_heavy.cc
 google/protobuf/generated_message_reflection.cc
 google/protobuf/message.cc
 google/protobuf/reflection_ops.cc
 google/protobuf/service.cc
 google/protobuf/text_format.cc
 google/protobuf/unknown_field_set.cc
 google/protobuf/wire_format.cc
 google/protobuf/io/gzip_stream.cc
 google/protobuf/io/printer.cc
 google/protobuf/io/tokenizer.cc
 google/protobuf/io/zero_copy_stream_impl.cc
 google/protobuf/compiler/importer.cc
 google/protobuf/compiler/parser.cc
 )
set(LIBPROTOBUF_INCLUDES ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/..)

add_library(protobuf SHARED ${LIBPROTOBUF_SOURCES})
include_directories(${LIBPROTOBUF_INCLUDES})
set_target_properties(protobuf PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(protobuf pthread)

# Target 2
set(LIBPROTOC_SOURCES
 google/protobuf/compiler/code_generator.cc
 google/protobuf/compiler/command_line_interface.cc
 google/protobuf/compiler/plugin.cc
 google/protobuf/compiler/plugin.pb.cc
 google/protobuf/compiler/subprocess.cc
 google/protobuf/compiler/subprocess.h
 google/protobuf/compiler/zip_writer.cc
 google/protobuf/compiler/zip_writer.h
 google/protobuf/compiler/cpp/cpp_enum.cc
 google/protobuf/compiler/cpp/cpp_enum.h
 google/protobuf/compiler/cpp/cpp_enum_field.cc
 google/protobuf/compiler/cpp/cpp_enum_field.h
 google/protobuf/compiler/cpp/cpp_extension.cc
 google/protobuf/compiler/cpp/cpp_extension.h
 google/protobuf/compiler/cpp/cpp_field.cc
 google/protobuf/compiler/cpp/cpp_field.h
 google/protobuf/compiler/cpp/cpp_file.cc
 google/protobuf/compiler/cpp/cpp_file.h
 google/protobuf/compiler/cpp/cpp_generator.cc
 google/protobuf/compiler/cpp/cpp_helpers.cc
 google/protobuf/compiler/cpp/cpp_helpers.h
 google/protobuf/compiler/cpp/cpp_message.cc
 google/protobuf/compiler/cpp/cpp_message.h
 google/protobuf/compiler/cpp/cpp_message_field.cc
 google/protobuf/compiler/cpp/cpp_message_field.h
 google/protobuf/compiler/cpp/cpp_primitive_field.cc
 google/protobuf/compiler/cpp/cpp_primitive_field.h
 google/protobuf/compiler/cpp/cpp_service.cc
 google/protobuf/compiler/cpp/cpp_service.h
 google/protobuf/compiler/cpp/cpp_string_field.cc
 google/protobuf/compiler/cpp/cpp_string_field.h
 google/protobuf/compiler/java/java_enum.cc
 google/protobuf/compiler/java/java_enum.h
 google/protobuf/compiler/java/java_enum_field.cc
 google/protobuf/compiler/java/java_enum_field.h
 google/protobuf/compiler/java/java_extension.cc
 google/protobuf/compiler/java/java_extension.h
 google/protobuf/compiler/java/java_field.cc
 google/protobuf/compiler/java/java_field.h
 google/protobuf/compiler/java/java_file.cc
 google/protobuf/compiler/java/java_file.h
 google/protobuf/compiler/java/java_generator.cc
 google/protobuf/compiler/java/java_helpers.cc
 google/protobuf/compiler/java/java_helpers.h
 google/protobuf/compiler/java/java_message.cc
 google/protobuf/compiler/java/java_message.h
 google/protobuf/compiler/java/java_message_field.cc
 google/protobuf/compiler/java/java_message_field.h
 google/protobuf/compiler/java/java_primitive_field.cc
 google/protobuf/compiler/java/java_primitive_field.h
 google/protobuf/compiler/java/java_service.cc
 google/protobuf/compiler/java/java_service.h
 google/protobuf/compiler/python/python_generator.cc
 )
# set(LIBPROTOC_INCLUDES ${CMAKE_SOURCE_DIR} ${CMAKE_SOURCE_DIR}/..)
set(LIBPROTOC_LIBRARY_INCLUDES ${LIBRARY_OUTPUT_PATH})

add_library(protoc SHARED ${LIBPROTOC_SOURCES})
include_directories($LIBPROTOC_INCLUDES)
link_directories(${LIBPROTOC_LIBRARY_INCLUDES})
set_target_properties(protoc PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(protoc pthread protobuf)

# Target 3
set(PROTOC_SOURCES google/protobuf/compiler/main.cc)
add_executable(protoc_compiler ${PROTOC_SOURCES})
set_target_properties(protoc_compiler PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread
                      OUTPUT_NAME protoc)
link_directories(${LIBRARY_OUTPUT_PATH})
target_link_libraries(protoc_compiler pthread protoc z)
