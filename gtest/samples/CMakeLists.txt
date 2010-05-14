#Generate samples library
add_library(samples SHARED
            sample1.cc
            sample2.cc
            sample4.cc)
set_target_properties(samples         PROPERTIES
                      LINK_FLAGS      -pthread
                      CMAKE_CXX_FLAGS -pthread)
target_link_libraries(samples gtest gtest_main pthread)

# Generate sample unit tests
GTEST_CXX(sample1_unittest
          sample1_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(sample2_unittest
          sample2_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(sample3_unittest
          sample3_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(sample4_unittest
          sample4_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(sample5_unittest
          sample5_unittest.cc
          -pthread
          -pthread
          "gtest_main;samples"
          "")

GTEST_CXX(sample6_unittest
          sample6_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(sample7_unittest
          sample7_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(sample8_unittest
          sample8_unittest.cc
          -pthread
          -pthread
          gtest_main
          "")

GTEST_CXX(sample9_unittest
          sample9_unittest.cc
          -pthread
          -pthread
          gtest
          "")

GTEST_CXX(sample10_unittest
          sample10_unittest.cc
          -pthread
          -pthread
          gtest
          "")
