cmake_minimum_required(VERSION 2.8)
project(gtest)

include_directories(
 ${CMAKE_CURRENT_SOURCE_DIR}
 ${CMAKE_CURRENT_SOURCE_DIR}/include)
link_directories(${CMAKE_CURRENT_BINARY_DIR})

# Generate gtest library
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

# Generate gtest_main library
add_library(gtest_main SHARED src/gtest_main.cc)
set_target_properties(gtest_main     PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(gtest_main gtest pthread)

#Generate samples library
add_library(samples SHARED
            samples/sample1.cc
            samples/sample2.cc
            samples/sample4.cc)
set_target_properties(samples         PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(samples gtest gtest_main pthread)

# Generate C++ tests
MACRO(GTEST_CXX
      TARGET_NAME SOURCES CXX_FLAGS LINK_FLAGS LINK_LIBS DEFINITIONS)
 add_executable(${TARGET_NAME} ${SOURCES})
 set_target_properties(${TARGET_NAME}  PROPERTIES
                       CMAKE_CXX_FLAGS ${CXX_FLAGS}
                       LINK_FLAGS      ${LINK_FLAGS}
                       COMPILE_DEFINITIONS "${DEFINITIONS}")
 target_link_libraries(${TARGET_NAME} ${LINK_LIBS})
 add_test(${TARGET_NAME} ${TARGET_NAME})
endmacro(GTEST_CXX)

# Generate sample unit tests
GTEST_CXX(samples/sample1_unittest
          samples/sample1_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(samples/sample2_unittest
          samples/sample2_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(samples/sample3_unittest
          samples/sample3_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(samples/sample4_unittest
          samples/sample4_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(samples/sample5_unittest
          samples/sample5_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(samples/sample6_unittest
          samples/sample6_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(samples/sample7_unittest
          samples/sample7_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(samples/sample8_unittest
          samples/sample8_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(samples/sample9_unittest
          samples/sample9_unittest.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(samples/sample10_unittest
          samples/sample10_unittest.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest-death-test_test
          test/gtest-death-test_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_environment_test
          test/gtest_environment_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest-filepath_test
          test/gtest-filepath_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest-linked_ptr_test
          test/gtest-linked_ptr_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_main_unittest
          test/gtest_main_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest-message_test
          test/gtest-message_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_no_test_unittest
          test/gtest_no_test_unittest.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest-options_test
          test/gtest-options_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest-param-test_test
          "test/gtest-param-test_test.cc;test/gtest-param-test2_test.cc"
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest-port_test
          test/gtest-port_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_pred_impl_unittest
          test/gtest_pred_impl_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_prod_test
          "test/gtest_prod_test.cc;test/production.cc"
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_repeat_test
          test/gtest_repeat_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest_sole_header_test
          test/gtest_sole_header_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_stress_test
          test/gtest_stress_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(test/gtest-test-part_test
          test/gtest-test-part_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_throw_on_failure_ex_test
          "test/gtest_throw_on_failure_ex_test.cc;src/gtest-all.cc"
          "-pthread -fexceptions"
          -pthread
          ""
          "")

GTEST_CXX(test/gtest-typed-test_test
          "test/gtest-typed-test_test.cc;test/gtest-typed-test2_test.cc"
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest_unittest
          test/gtest_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest-unittest-api_test
          test/gtest-unittest-api_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(test/gtest-listener_test
          test/gtest-listener_test.cc
          -pthread
          -pthread
          gtest_main
          "")

# Verifies that Google Test works when RTTI is disabled.
GTEST_CXX(test/gtest_no_rtti_test
          "test/gtest_unittest.cc;src/gtest-all.cc;src/gtest_main.cc"
          "-pthread -fno-rtti"
          -pthread
          ""
          "GTEST_HAS_RTTI=0")

# Verifies that Google Test's own TR1 tuple implementation works.
GTEST_CXX(test/gtest-tuple_test
                "test/gtest-tuple_test.cc;src/gtest-all.cc;src/gtest_main.cc"
                "-pthread"
                -pthread
                ""
                "GTEST_USE_OWN_TR1_TUPLE=1")

# Verifies that Google Test's features that use its own TR1 tuple work.
GTEST_CXX(test/gtest_use_own_tuple_test
                "test/gtest-param-test_test.cc;test/gtest-param-test2_test.cc;src/gtest-all.cc"
                "-pthread"
                -pthread
                ""
                "GTEST_USE_OWN_TR1_TUPLE=1")

find_package(PythonInterp QUIET)
find_package(PythonLibs   QUIET)

# Generate Python tests
MACRO(GTEST_PYTHON
      PYTHON_SCRIPT TARGET_NAME SOURCES CXX_FLAGS LINK_FLAGS LINK_LIBS DEFINITIONS)
 add_executable(${TARGET_NAME} ${SOURCES})
 set_target_properties(${TARGET_NAME}  PROPERTIES
                       CMAKE_CXX_FLAGS ${CXX_FLAGS}
                       LINK_FLAGS      ${LINK_FLAGS}
                       COMPILE_DEFINITIONS "${DEFINITIONS}")
 target_link_libraries(${TARGET_NAME} ${LINK_LIBS})
 add_test(${TARGET_NAME} ${PYTHON_EXECUTABLE} ${PYTHON_SCRIPT})
endmacro(GTEST_PYTHON)

if (PythonInterp_FOUND AND PythonLibs_FOUND)
 # Build Python tests
check_SCRIPTS += test/gtest_test_utils.py \
                 test/gtest_xml_test_utils.py

check_PROGRAMS += test/gtest_break_on_failure_unittest_
test_gtest_break_on_failure_unittest__SOURCES = \
  test/gtest_break_on_failure_unittest_.cc
test_gtest_break_on_failure_unittest__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_break_on_failure_unittest.py
TESTS += test/gtest_break_on_failure_unittest.py

check_PROGRAMS += test/gtest_color_test_
test_gtest_color_test__SOURCES = test/gtest_color_test_.cc
test_gtest_color_test__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_color_test.py
TESTS += test/gtest_color_test.py

check_PROGRAMS += test/gtest_env_var_test_
test_gtest_env_var_test__SOURCES = test/gtest_env_var_test_.cc
test_gtest_env_var_test__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_env_var_test.py
TESTS += test/gtest_env_var_test.py

check_PROGRAMS += test/gtest_filter_unittest_
test_gtest_filter_unittest__SOURCES = test/gtest_filter_unittest_.cc
test_gtest_filter_unittest__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_filter_unittest.py
TESTS += test/gtest_filter_unittest.py

check_PROGRAMS += test/gtest_help_test_
test_gtest_help_test__SOURCES = test/gtest_help_test_.cc
test_gtest_help_test__LDADD = lib/libgtest_main.la
check_SCRIPTS += test/gtest_help_test.py
TESTS += test/gtest_help_test.py

check_PROGRAMS += test/gtest_list_tests_unittest_
test_gtest_list_tests_unittest__SOURCES = test/gtest_list_tests_unittest_.cc
test_gtest_list_tests_unittest__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_list_tests_unittest.py
TESTS += test/gtest_list_tests_unittest.py

check_PROGRAMS += test/gtest_output_test_
test_gtest_output_test__SOURCES = test/gtest_output_test_.cc
test_gtest_output_test__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_output_test.py
EXTRA_DIST += test/gtest_output_test_golden_lin.txt \
              test/gtest_output_test_golden_win.txt
TESTS += test/gtest_output_test.py

check_PROGRAMS += test/gtest_shuffle_test_
test_gtest_shuffle_test__SOURCES = test/gtest_shuffle_test_.cc
test_gtest_shuffle_test__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_shuffle_test.py
TESTS += test/gtest_shuffle_test.py

check_PROGRAMS += test/gtest_throw_on_failure_test_
test_gtest_throw_on_failure_test__SOURCES = \
  test/gtest_throw_on_failure_test_.cc \
  src/gtest-all.cc
test_gtest_throw_on_failure_test__CXXFLAGS = $(AM_CXXFLAGS) -fno-exceptions
check_SCRIPTS += test/gtest_throw_on_failure_test.py
TESTS += test/gtest_throw_on_failure_test.py

check_PROGRAMS += test/gtest_uninitialized_test_
test_gtest_uninitialized_test__SOURCES = test/gtest_uninitialized_test_.cc
test_gtest_uninitialized_test__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_uninitialized_test.py
TESTS += test/gtest_uninitialized_test.py

check_PROGRAMS += test/gtest_xml_outfile1_test_
test_gtest_xml_outfile1_test__SOURCES = test/gtest_xml_outfile1_test_.cc
test_gtest_xml_outfile1_test__LDADD = lib/libgtest_main.la
check_PROGRAMS += test/gtest_xml_outfile2_test_
test_gtest_xml_outfile2_test__SOURCES = test/gtest_xml_outfile2_test_.cc
test_gtest_xml_outfile2_test__LDADD = lib/libgtest_main.la
check_SCRIPTS += test/gtest_xml_outfiles_test.py
TESTS += test/gtest_xml_outfiles_test.py

check_PROGRAMS += test/gtest_xml_output_unittest_
test_gtest_xml_output_unittest__SOURCES = test/gtest_xml_output_unittest_.cc
test_gtest_xml_output_unittest__LDADD = lib/libgtest.la
check_SCRIPTS += test/gtest_xml_output_unittest.py
TESTS += test/gtest_xml_output_unittest.py

# TODO(wan@google.com): make the build script compile and run the
#   negative-compilation tests.  (The test/gtest_nc* files are unfinished
#   implementation of tests for verifying that certain kinds of misuse
#   of Google Test don't compile.)
EXTRA_DIST += $(check_SCRIPTS) \
              test/gtest_nc.cc \
              test/gtest_nc_test.py

endif
endif ()
