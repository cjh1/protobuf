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

 # See if we found a successful compile for both hash_map and hash_set
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
if (CMAKE_CROSSCOMPILING)
  #Don't refuse to compile the runtime just because threads are missing
  set(HAVE_PTHREAD 1)
endif (CMAKE_CROSSCOMPILING)
configure_file(${CMAKE_CURRENT_SOURCE_DIR}/config.h.cmake.in
               ${CMAKE_CURRENT_BINARY_DIR}/config.h)

# Include directories for this project
if (ZLIB_FOUND)
  include_directories(${ZLIB_INCLUDE_DIRS})
endif ()
include_directories(
 ${CMAKE_CURRENT_BINARY_DIR}
 ${CMAKE_CURRENT_SOURCE_DIR}
 ${CMAKE_SOURCE_DIR}
 ${CMAKE_SOURCE_DIR}/..)

# Targets ==============================================================
# protobuf library
set(LIBPROTOBUF_SOURCES
 google/protobuf/stubs/common.cc
 google/protobuf/stubs/once.cc
 google/protobuf/stubs/hash.cc
 google/protobuf/extension_set.cc
 google/protobuf/generated_message_util.cc
 google/protobuf/message_lite.cc
 google/protobuf/repeated_field.cc
 google/protobuf/wire_format_lite.cc
 google/protobuf/io/coded_stream.cc
 google/protobuf/io/zero_copy_stream.cc
 google/protobuf/io/zero_copy_stream_impl_lite.cc
 google/protobuf/stubs/strutil.cc
 google/protobuf/stubs/substitute.cc
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
 google/protobuf/compiler/parser.cc)
add_library(protobuf ${LIBPROTOBUF_SOURCES})
if (WIN32 AND BUILD_SHARED_LIBS)
 set_target_properties(protobuf PROPERTIES
                       COMPILE_DEFINITIONS LIBPROTOBUF_EXPORTS)
endif (WIN32 AND BUILD_SHARED_LIBS)
target_link_libraries(protobuf ${THREAD_LINK_LIB} ${ZLIB_LINK_LIB})

# protobuf-lite library
set(PROTOBUF_LITE_SOURCES
 google/protobuf/stubs/common.cc
 google/protobuf/stubs/once.cc
 google/protobuf/stubs/hash.cc
 google/protobuf/extension_set.cc
 google/protobuf/generated_message_util.cc
 google/protobuf/message_lite.cc
 google/protobuf/repeated_field.cc
 google/protobuf/wire_format_lite.cc
 google/protobuf/io/coded_stream.cc
 google/protobuf/io/zero_copy_stream.cc
 google/protobuf/io/zero_copy_stream_impl_lite.cc)
add_library(protobuf-lite ${PROTOBUF_LITE_SOURCES})
if (WIN32 AND BUILD_SHARED_LIBS)
 set_target_properties(protobuf-lite PROPERTIES
                       COMPILE_DEFINITIONS LIBPROTOBUF_EXPORTS)
endif (WIN32 AND BUILD_SHARED_LIBS)
target_link_libraries(protobuf-lite ${THREAD_LINK_LIB})

# protoc library
set(LIBPROTOC_SOURCES
 google/protobuf/compiler/code_generator.cc
 google/protobuf/compiler/command_line_interface.cc
 google/protobuf/compiler/plugin.cc
 google/protobuf/compiler/plugin.pb.cc
 google/protobuf/compiler/subprocess.cc
 google/protobuf/compiler/zip_writer.cc
 google/protobuf/compiler/cpp/cpp_enum.cc
 google/protobuf/compiler/cpp/cpp_enum_field.cc
 google/protobuf/compiler/cpp/cpp_extension.cc
 google/protobuf/compiler/cpp/cpp_field.cc
 google/protobuf/compiler/cpp/cpp_file.cc
 google/protobuf/compiler/cpp/cpp_generator.cc
 google/protobuf/compiler/cpp/cpp_helpers.cc
 google/protobuf/compiler/cpp/cpp_message.cc
 google/protobuf/compiler/cpp/cpp_message_field.cc
 google/protobuf/compiler/cpp/cpp_primitive_field.cc
 google/protobuf/compiler/cpp/cpp_service.cc
 google/protobuf/compiler/cpp/cpp_string_field.cc
 google/protobuf/compiler/java/java_enum.cc
 google/protobuf/compiler/java/java_enum_field.cc
 google/protobuf/compiler/java/java_extension.cc
 google/protobuf/compiler/java/java_field.cc
 google/protobuf/compiler/java/java_file.cc
 google/protobuf/compiler/java/java_generator.cc
 google/protobuf/compiler/java/java_helpers.cc
 google/protobuf/compiler/java/java_message.cc
 google/protobuf/compiler/java/java_message_field.cc
 google/protobuf/compiler/java/java_primitive_field.cc
 google/protobuf/compiler/java/java_service.cc
 google/protobuf/compiler/python/python_generator.cc)
link_directories(${LIBRARY_OUTPUT_PATH})
add_library(protoc ${LIBPROTOC_SOURCES})
if (WIN32 AND BUILD_SHARED_LIBS)
 set_target_properties(protoc PROPERTIES
                       COMPILE_DEFINITIONS LIBPROTOC_EXPORTS)
endif (WIN32 AND BUILD_SHARED_LIBS)
target_link_libraries(protoc ${THREAD_LINK_LIB} protobuf)

# protoc executable
link_directories(${LIBRARY_OUTPUT_PATH})

IF(NOT CMAKE_CROSSCOMPILING)
   add_executable(protoc_compiler google/protobuf/compiler/main.cc)
   set_target_properties(protoc_compiler PROPERTIES
                         OUTPUT_NAME     protoc)
   target_link_libraries(protoc_compiler
                         ${THREAD_LINK_LIB}
                         protobuf
                         protoc
                         ${ZLIB_LINK_LIB})
   get_target_property(protoc_compiler_location protoc_compiler LOCATION)
   EXPORT(TARGETS protoc_compiler
          FILE ${EXPORT_EXECUTABLES_FILE}
          NAMESPACE "${EXPORT_EXECUTABLES_NAMESPACE}"
          APPEND)
ENDIF(NOT CMAKE_CROSSCOMPILING)

if(protobuf_ENABLE_TESTING)
  # Generate test sources
  set(PROTOC_INPUTS
    google/protobuf/unittest
    google/protobuf/unittest_empty
    google/protobuf/unittest_import
    google/protobuf/unittest_mset
    google/protobuf/unittest_optimize_for
    google/protobuf/unittest_embed_optimize_for
    google/protobuf/unittest_custom_options
    google/protobuf/unittest_lite
    google/protobuf/unittest_import_lite
    google/protobuf/unittest_lite_imports_nonlite
    google/protobuf/unittest_no_generic_services
    google/protobuf/compiler/cpp/cpp_test_bad_identifiers)
  foreach(PROTOBUF_SAMPLE_INPUT ${PROTOC_INPUTS})
    add_custom_command(OUTPUT ${PROTOBUF_SAMPLE_INPUT}.pb.cc
                              ${PROTOBUF_SAMPLE_INPUT}.pb.h
                       COMMAND ${protoc_compiler_location}
                               ARGS ${CMAKE_CURRENT_SOURCE_DIR}/${PROTOBUF_SAMPLE_INPUT}.proto
                                    --proto_path="${CMAKE_CURRENT_SOURCE_DIR}"
                                    --cpp_out="${CMAKE_BINARY_DIR}/src"
                        DEPENDS protoc_compiler ${PROTOBUF_SAMPLE_INPUT}.proto)
  # I am not quite sure why, buy I have to have this command below to 
  # make sure it works for Visual Studio
    if (WIN32)
      add_custom_command(TARGET protoc_compiler
                         COMMAND ${protoc_compiler_location}
                                 ARGS ${CMAKE_CURRENT_SOURCE_DIR}/${PROTOBUF_SAMPLE_INPUT}.proto
                                      --proto_path="${CMAKE_CURRENT_SOURCE_DIR}"
                                      --cpp_out="${CMAKE_BINARY_DIR}/src")
    endif(WIN32)
  endforeach()

  # Tests ==============================================================
  set(PROTOC_LITE_OUTPUTS
    google/protobuf/unittest_lite.pb.cc
    google/protobuf/unittest_import_lite.pb.cc)
  set(PROTOC_OUTPUTS ${PROTOC_LITE_OUTPUTS}
    google/protobuf/unittest.pb.cc
    google/protobuf/unittest_empty.pb.cc
    google/protobuf/unittest_import.pb.cc
    google/protobuf/unittest_mset.pb.cc
    google/protobuf/unittest_optimize_for.pb.cc
    google/protobuf/unittest_embed_optimize_for.pb.cc
    google/protobuf/unittest_custom_options.pb.cc
    google/protobuf/unittest_lite_imports_nonlite.pb.cc
    google/protobuf/unittest_no_generic_services.pb.cc
    google/protobuf/compiler/cpp/cpp_test_bad_identifiers.pb.cc)
  set(COMMON_TEST_SOURCES
    google/protobuf/test_util.cc
    google/protobuf/testing/googletest.cc
    google/protobuf/testing/file.cc)
  set(PROTOBUF_TEST_SOURCES
    google/protobuf/stubs/common_unittest.cc
    google/protobuf/stubs/once_unittest.cc
    google/protobuf/stubs/strutil_unittest.cc
    google/protobuf/stubs/structurally_valid_unittest.cc
    google/protobuf/descriptor_database_unittest.cc
    google/protobuf/descriptor_unittest.cc
    google/protobuf/dynamic_message_unittest.cc
    google/protobuf/extension_set_unittest.cc
    google/protobuf/generated_message_reflection_unittest.cc
    google/protobuf/message_unittest.cc
    google/protobuf/reflection_ops_unittest.cc
    google/protobuf/repeated_field_unittest.cc
    google/protobuf/text_format_unittest.cc
    google/protobuf/unknown_field_set_unittest.cc
    google/protobuf/wire_format_unittest.cc
    google/protobuf/io/coded_stream_unittest.cc
    google/protobuf/io/printer_unittest.cc
    google/protobuf/io/tokenizer_unittest.cc
    google/protobuf/io/zero_copy_stream_unittest.cc
    google/protobuf/compiler/command_line_interface_unittest.cc
    google/protobuf/compiler/importer_unittest.cc
    google/protobuf/compiler/mock_code_generator.cc
    google/protobuf/compiler/parser_unittest.cc
    google/protobuf/compiler/cpp/cpp_bootstrap_unittest.cc
    google/protobuf/compiler/cpp/cpp_unittest.cc
    google/protobuf/compiler/cpp/cpp_plugin_unittest.cc
    google/protobuf/compiler/java/java_plugin_unittest.cc
    google/protobuf/compiler/python/python_plugin_unittest.cc)
  include_directories(${CMAKE_SOURCE_DIR}/gtest/include ${CMAKE_BINARY_DIR}/src)

  # protobuf-test
  add_executable(protobuf_test
                 ${PROTOBUF_TEST_SOURCES}
                 ${COMMON_TEST_SOURCES}
                 ${PROTOC_OUTPUTS})
  target_link_libraries(protobuf_test ${THREAD_LINK_LIB}
                        protobuf
                        protoc
                        gtest
                        gtest_main
                        ${ZLIB_LINK_LIB})
  add_test(protobuf_test ${EXECUTABLE_OUTPUT_PATH}/protobuf_test)

  # protobuf-lazy-descriptor-test
  add_executable(protobuf_lazy_descriptor_test
                 google/protobuf/compiler/cpp/cpp_unittest.cc
                 ${COMMON_TEST_SOURCES}
                 ${PROTOC_OUTPUTS})
  set_target_properties(protobuf_lazy_descriptor_test PROPERTIES
                        COMPILE_DEFINITIONS "PROTOBUF_TEST_NO_DESCRIPTORS")
  target_link_libraries(protobuf_lazy_descriptor_test
                        ${THREAD_LINK_LIB}
                        protobuf
                        gtest
                        gtest_main
                        ${ZLIB_LINK_LIB})
  add_test(protobuf_lazy_descriptor_test ${EXECUTABLE_OUTPUT_PATH}/protobuf_lazy_descriptor_test)

  # lite-unittest
  add_executable(lite_unittest
                 google/protobuf/lite_unittest.cc
                 google/protobuf/test_util_lite.cc
                 ${PROTOC_LITE_OUTPUTS})
  target_link_libraries(lite_unittest
                        ${THREAD_LINK_LIB}
                        protobuf-lite
                        ${ZLIB_LINK_LIB})
  add_test(lite_unittest ${EXECUTABLE_OUTPUT_PATH}/lite_unittest)

  # plugins
  add_executable(test_plugin
                 google/protobuf/compiler/mock_code_generator.cc
                 google/protobuf/testing/file.cc
                 google/protobuf/compiler/test_plugin.cc)
#                 ${PROTOC_LITE_OUTPUTS})
  set_target_properties(test_plugin PROPERTIES
                        RUNTIME_OUTPUT_DIRECTORY         "${CMAKE_BINARY_DIR}/src"
                        RUNTIME_OUTPUT_DIRECTORY_DEBUG   "${CMAKE_BINARY_DIR}/src"
                        RUNTIME_OUTPUT_DIRECTORY_RELEASE "${CMAKE_BINARY_DIR}/src")
  target_link_libraries(test_plugin
                        ${THREAD_LINK_LIB}
                        protobuf
                        protoc
                        gtest
                        ${ZLIB_LINK_LIB})
  # test_plugin by itself is not a valid test program,
  # it is used with/called by protobuf_test which is the main
  # test program to test plugin facility.
  # add_test(test_plugin ${EXECUTABLE_OUTPUT_PATH}/test_plugin)

  # zlib
  if (ZLIB_FOUND)
    set(ZCGZIP_SOURCES google/protobuf/testing/zcgzip.cc)
    add_executable(zcgzip ${ZCGZIP_SOURCES})
    target_link_libraries(zcgzip ${THREAD_LINK_LIB} protobuf ${ZLIB_LINK_LIB})

    set(ZCGUNZIP_SOURCES google/protobuf/testing/zcgunzip.cc)
    add_executable(zcgunzip ${ZCGUNZIP_SOURCES})
    target_link_libraries(zcgunzip ${THREAD_LINK_LIB} protobuf ${ZLIB_LINK_LIB})

    # I went through the original Makefile.am file and cannot find any useage
    # of these files. Actually, when I removed these files from the test directory
    # all the tests still run pretty well which leads me to assume that they are
    # not used.
    # I also read the source code for zcgzip which seems to me only
    # read from STDIN and outpu to STDOUT. This suggests that you cannot do
    # automatical tests with those configurations. Of course, redirection should
    # be able to make zcgzip work with files. However, I do not see any
    # redirection operation from the make ckeck command line.
    # add_test(zcgzip   ${EXECUTABLE_OUTPUT_PATH}/zcgzip)
    # add_test(zcgunzip ${EXECUTABLE_OUTPUT_PATH}/zcgunzip)
  endif ()

  # Copy these dest files to position - the test requires them
  foreach(EXTRA_DIST_I
    ${PROTOC_INPUTS}
    google/protobuf/descriptor
    google/protobuf/compiler/plugin)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${EXTRA_DIST_I}.proto
                   ${CMAKE_BINARY_DIR}/src/${EXTRA_DIST_I}.proto
                   COPYONLY)
  endforeach(EXTRA_DIST_I)
  foreach(EXTRA_DIST_I
    google/protobuf/descriptor.pb.h
    google/protobuf/descriptor.pb.cc
    google/protobuf/compiler/plugin.pb.h
    google/protobuf/compiler/plugin.pb.cc
    solaris/libstdc++.la
    google/protobuf/io/gzip_stream.h
    google/protobuf/io/gzip_stream_unittest.sh
    google/protobuf/testdata/golden_message
    google/protobuf/testdata/golden_packed_fields_message
    google/protobuf/testdata/text_format_unittest_data.txt
    google/protobuf/testdata/text_format_unittest_extensions_data.txt
    google/protobuf/package_info.h
    google/protobuf/io/package_info.h
    google/protobuf/compiler/package_info.h
    google/protobuf/compiler/zip_output_unittest.sh
    google/protobuf/unittest_enormous_descriptor.proto)
    configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${EXTRA_DIST_I}
                   ${CMAKE_BINARY_DIR}/src/${EXTRA_DIST_I}
                   COPYONLY)
  endforeach(EXTRA_DIST_I)
endif() # End of tests (only compiled when requested now.

IF(NOT CMAKE_CROSSCOMPILING)
  export(TARGETS protobuf protobuf-lite protoc protoc_compiler FILE "${PROTOBUF_EXPORTS_FILE}")
ELSE(NOT CMAKE_CROSSCOMPILING)
  export(TARGETS protobuf protobuf-lite protoc FILE "${PROTOBUF_EXPORTS_FILE}")
ENDIF(NOT CMAKE_CROSSCOMPILING)

install (TARGETS protobuf protobuf-lite
  EXPORT ${PROTOBUF_INSTALL_EXPORT_NAME}
  RUNTIME DESTINATION ${PROTOBUF_INSTALL_BIN_DIR} COMPONENT Runtime
  LIBRARY DESTINATION ${PROTOBUF_INSTALL_LIB_DIR} COMPONENT Runtime
  ARCHIVE DESTINATION ${PROTOBUF_INSTALL_LIB_DIR} COMPONENT Development)

IF(COMPILE_TOOLS_TARGET)
  ADD_DEPENDENCIES(${COMPILE_TOOLS_TARGET} protoc_compiler)
ENDIF(COMPILE_TOOLS_TARGET)
