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

if (EXISTS "${PYTHON_EXECUTABLE}" AND EXISTS "${PYTHON_LIBRARY}")
 execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different "gtest_test_utils.py" ${EXECUTABLE_OUTPUT_PATH})
 execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different "gtest_xml_test_utils.py" ${EXECUTABLE_OUTPUT_PATH})
 # Build Python tests
 GTEST_PYTHON(gtest_break_on_failure_unittest_
              gtest_break_on_failure_unittest_.cc
              -pthread
              -pthread
              gtest
              gtest_break_on_failure_unittest.py)

 GTEST_PYTHON(gtest_color_test_
              gtest_color_test_.cc
              -pthread
              -pthread
              gtest
              gtest_color_test.py)

 GTEST_PYTHON(gtest_env_var_test_
              gtest_env_var_test_.cc
              -pthread
              -pthread
              gtest
              gtest_env_var_test.py)

 GTEST_PYTHON(gtest_filter_unittest_
              gtest_filter_unittest_.cc
              -pthread
              -pthread
              gtest
              gtest_filter_unittest.py)

 GTEST_PYTHON(gtest_help_test_
              gtest_help_test_.cc
              -pthread
              -pthread
              gtest_main
              gtest_help_test.py)

 GTEST_PYTHON(gtest_list_tests_unittest_
              gtest_list_tests_unittest_.cc
              -pthread
              -pthread
              gtest
              gtest_list_tests_unittest.py)

 GTEST_PYTHON(gtest_output_test_
              gtest_output_test_.cc
              -pthread
              -pthread
              gtest
              gtest_output_test.py)

 GTEST_PYTHON(gtest_shuffle_test_
              gtest_shuffle_test_.cc
              -pthread
              -pthread
              gtest
              gtest_shuffle_test.py)

 GTEST_PYTHON(gtest_throw_on_failure_test_
              "gtest_throw_on_failure_test_.cc;../src/gtest-all.cc"
              "-pthread -fno-exceptions"
              -pthread
              ""
              gtest_throw_on_failure_test.py)

 GTEST_PYTHON(gtest_uninitialized_test_
              gtest_uninitialized_test_.cc
              -pthread
              -pthread
              gtest
              gtest_uninitialized_test.py)

 GTEST_PYTHON(gtest_xml_outfile1_test_
              gtest_xml_outfile1_test_.cc
              -pthread
              -pthread
              gtest_main
              gtest_xml_outfiles_test.py)

 GTEST_PYTHON(gtest_xml_outfile2_test_
              gtest_xml_outfile2_test_.cc
              -pthread
              -pthread
              gtest_main
              gtest_xml_outfiles_test.py)

 GTEST_PYTHON(gtest_xml_output_unittest_
              gtest_xml_output_unittest_.cc
              -pthread
              -pthread
              gtest
              gtest_xml_output_unittest.py)
endif ()
