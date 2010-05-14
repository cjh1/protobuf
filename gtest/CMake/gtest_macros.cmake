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
