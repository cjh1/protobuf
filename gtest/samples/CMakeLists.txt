#Generate samples library
set(GTEST_SAMPLE_SOURCES
    sample1.cc
    sample2.cc
    sample4.cc)
if (WIN32)
 add_library(samples STATIC ${GTEST_SAMPLE_SOURCES})
else (WIN32)
 add_library(samples ${GTEST_SAMPLE_SOURCES})
endif (WIN32)

target_link_libraries(samples gtest gtest_main ${THREAD_LINK_LIB})

# Generate sample unit tests
GTEST_CXX(sample1_unittest
          sample1_unittest.cc
          ""
          ""
          "gtest_main;samples;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample2_unittest
          sample2_unittest.cc
          ""
          ""
          "gtest_main;samples;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample3_unittest
          sample3_unittest.cc
          ""
          ""
          "gtest_main;samples;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample4_unittest
          sample4_unittest.cc
          ""
          ""
          "gtest_main;samples;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample5_unittest
          sample5_unittest.cc
          ""
          ""
          "gtest_main;samples;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample6_unittest
          sample6_unittest.cc
          ""
          ""
          "gtest_main;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample7_unittest
          sample7_unittest.cc
          ""
          ""
          "gtest_main;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample8_unittest
          sample8_unittest.cc
          ""
          ""
          "gtest_main;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample9_unittest
          sample9_unittest.cc
          ""
          ""
          "gtest;${THREAD_LINK_LIB}"
          "")

GTEST_CXX(sample10_unittest
          sample10_unittest.cc
          ""
          ""
          "gtest;${THREAD_LINK_LIB}"
          "")
