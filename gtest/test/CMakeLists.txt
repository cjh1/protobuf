GTEST_CXX(gtest-death-test_test
          gtest-death-test_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_environment_test
          gtest_environment_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(gtest-filepath_test
          gtest-filepath_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest-linked_ptr_test
          gtest-linked_ptr_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_main_unittest
          gtest_main_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest-message_test
          gtest-message_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_no_test_unittest
          gtest_no_test_unittest.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(gtest-options_test
          gtest-options_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest-param-test_test
          "gtest-param-test_test.cc;gtest-param-test2_test.cc"
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(gtest-port_test
          gtest-port_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_pred_impl_unittest
          gtest_pred_impl_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_prod_test
          "gtest_prod_test.cc;production.cc"
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_repeat_test
          gtest_repeat_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(gtest_sole_header_test
          gtest_sole_header_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_stress_test
          gtest_stress_test.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(gtest-test-part_test
          gtest-test-part_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_throw_on_failure_ex_test
          "gtest_throw_on_failure_ex_test.cc;../src/gtest-all.cc"
          "-pthread -fexceptions"
          -pthread
          ""
          "")

GTEST_CXX(gtest-typed-test_test
          "gtest-typed-test_test.cc;gtest-typed-test2_test.cc"
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest_unittest
          gtest_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest-unittest-api_test
          gtest-unittest-api_test.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(gtest-listener_test
          gtest-listener_test.cc
          -pthread
          -pthread
          gtest_main
          "")

# Verifies that Google Test works when RTTI is disabled.
GTEST_CXX(gtest_no_rtti_test
          "gtest_unittest.cc;../src/gtest-all.cc;../src/gtest_main.cc"
          "-pthread -fno-rtti"
          -pthread
          ""
          "GTEST_HAS_RTTI=0")

# Verifies that Google Test's own TR1 tuple implementation works.
GTEST_CXX(gtest-tuple_test
                "gtest-tuple_test.cc;../src/gtest-all.cc;../src/gtest_main.cc"
                "-pthread"
                -pthread
                ""
                "GTEST_USE_OWN_TR1_TUPLE=1")

# Verifies that Google Test's features that use its own TR1 tuple work.
GTEST_CXX(gtest_use_own_tuple_test
                "gtest-param-test_test.cc;gtest-param-test2_test.cc;../src/gtest-all.cc"
                "-pthread"
                -pthread
                ""
                "GTEST_USE_OWN_TR1_TUPLE=1")

find_package(PythonInterp QUIET)
find_package(PythonLibs   QUIET)

# if (PythonInterp_FOUND AND PythonLibs_FOUND)
#  # Build Python tests
# check_SCRIPTS += gtest_test_utils.py \
#                  gtest_xml_test_utils.py
# 
# check_PROGRAMS += gtest_break_on_failure_unittest_
# test_gtest_break_on_failure_unittest__SOURCES = \
#   gtest_break_on_failure_unittest_.cc
# test_gtest_break_on_failure_unittest__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_break_on_failure_unittest.py
# TESTS += gtest_break_on_failure_unittest.py
# 
# check_PROGRAMS += gtest_color_test_
# test_gtest_color_test__SOURCES = gtest_color_test_.cc
# test_gtest_color_test__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_color_test.py
# TESTS += gtest_color_test.py
# 
# check_PROGRAMS += gtest_env_var_test_
# test_gtest_env_var_test__SOURCES = gtest_env_var_test_.cc
# test_gtest_env_var_test__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_env_var_test.py
# TESTS += gtest_env_var_test.py
# 
# check_PROGRAMS += gtest_filter_unittest_
# test_gtest_filter_unittest__SOURCES = gtest_filter_unittest_.cc
# test_gtest_filter_unittest__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_filter_unittest.py
# TESTS += gtest_filter_unittest.py
# 
# check_PROGRAMS += gtest_help_test_
# test_gtest_help_test__SOURCES = gtest_help_test_.cc
# test_gtest_help_test__LDADD = lib/libgtest_main.la
# check_SCRIPTS += gtest_help_test.py
# TESTS += gtest_help_test.py
# 
# check_PROGRAMS += gtest_list_tests_unittest_
# test_gtest_list_tests_unittest__SOURCES = gtest_list_tests_unittest_.cc
# test_gtest_list_tests_unittest__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_list_tests_unittest.py
# TESTS += gtest_list_tests_unittest.py
# 
# check_PROGRAMS += gtest_output_test_
# test_gtest_output_test__SOURCES = gtest_output_test_.cc
# test_gtest_output_test__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_output_test.py
# EXTRA_DIST += gtest_output_test_golden_lin.txt \
#               gtest_output_test_golden_win.txt
# TESTS += gtest_output_test.py
# 
# check_PROGRAMS += gtest_shuffle_test_
# test_gtest_shuffle_test__SOURCES = gtest_shuffle_test_.cc
# test_gtest_shuffle_test__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_shuffle_test.py
# TESTS += gtest_shuffle_test.py
# 
# check_PROGRAMS += gtest_throw_on_failure_test_
# test_gtest_throw_on_failure_test__SOURCES = \
#   gtest_throw_on_failure_test_.cc \
#   ../src/gtest-all.cc
# test_gtest_throw_on_failure_test__CXXFLAGS = $(AM_CXXFLAGS) -fno-exceptions
# check_SCRIPTS += gtest_throw_on_failure_test.py
# TESTS += gtest_throw_on_failure_test.py
# 
# check_PROGRAMS += gtest_uninitialized_test_
# test_gtest_uninitialized_test__SOURCES = gtest_uninitialized_test_.cc
# test_gtest_uninitialized_test__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_uninitialized_test.py
# TESTS += gtest_uninitialized_test.py
# 
# check_PROGRAMS += gtest_xml_outfile1_test_
# test_gtest_xml_outfile1_test__SOURCES = gtest_xml_outfile1_test_.cc
# test_gtest_xml_outfile1_test__LDADD = lib/libgtest_main.la
# check_PROGRAMS += gtest_xml_outfile2_test_
# test_gtest_xml_outfile2_test__SOURCES = gtest_xml_outfile2_test_.cc
# test_gtest_xml_outfile2_test__LDADD = lib/libgtest_main.la
# check_SCRIPTS += gtest_xml_outfiles_test.py
# TESTS += gtest_xml_outfiles_test.py
# 
# check_PROGRAMS += gtest_xml_output_unittest_
# test_gtest_xml_output_unittest__SOURCES = gtest_xml_output_unittest_.cc
# test_gtest_xml_output_unittest__LDADD = lib/libgtest.la
# check_SCRIPTS += gtest_xml_output_unittest.py
# TESTS += gtest_xml_output_unittest.py
# 
# # TODO(wan@google.com): make the build script compile and run the
# #   negative-compilation tests.  (The gtest_nc* files are unfinished
# #   implementation of tests for verifying that certain kinds of misuse
# #   of Google Test don't compile.)
# EXTRA_DIST += $(check_SCRIPTS) \
#               gtest_nc.cc \
#               gtest_nc_test.py
# 
# endif
# endif ()
