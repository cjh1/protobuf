#Generate samples library
add_library(samples
            sample1.cc
            sample2.cc
            sample4.cc)
set_target_properties(samples         PROPERTIES
                      CMAKE_CXX_FLAGS ${PTHREAD_CXX_FLAG}
                      LINK_FLAGS      ${PTHREAD_LINK_FLAG})
target_link_libraries(samples gtest gtest_main ${PTHREAD_LINK_LIB})

# Generate sample unit tests
GTEST_CXX(sample1_unittest
          sample1_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;samples;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample2_unittest
          sample2_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;samples;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample3_unittest
          sample3_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;samples;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample4_unittest
          sample4_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;samples;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample5_unittest
          sample5_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;samples;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample6_unittest
          sample6_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample7_unittest
          sample7_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample8_unittest
          sample8_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest_main;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample9_unittest
          sample9_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest;${PTHREAD_LINK_LIB}"
          "")

GTEST_CXX(sample10_unittest
          sample10_unittest.cc
          "${PTHREAD_CXX_FLAG}"
          "${PTHREAD_LINK_FLAG}"
          "gtest;${PTHREAD_LINK_LIB}"
          "")
