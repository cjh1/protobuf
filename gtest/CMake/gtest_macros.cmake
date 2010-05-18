# Generate C++ tests
MACRO(GTEST_CXX
      TARGET_NAME SOURCES CXX_FLAGS LINK_FLAGS LINK_LIBS DEFINITIONS)
 add_executable(${TARGET_NAME} ${SOURCES})
 set_target_properties(${TARGET_NAME}  PROPERTIES
                       CMAKE_CXX_FLAGS "${CXX_FLAGS}"
                       LINK_FLAGS      "${LINK_FLAGS}"
                       COMPILE_DEFINITIONS "${DEFINITIONS}")
 target_link_libraries(${TARGET_NAME} ${LINK_LIBS})
 add_test(${TARGET_NAME} ${EXECUTABLE_OUTPUT_PATH}/${TARGET_NAME})
endmacro(GTEST_CXX)

# Generate Python tests
MACRO(GTEST_PYTHON
      TARGET_NAME SOURCES CXX_FLAGS LINK_FLAGS LINK_LIBS PYTHON_SCRIPT)
 add_executable(${TARGET_NAME} ${SOURCES})
 set_target_properties(${TARGET_NAME}  PROPERTIES
                       CMAKE_CXX_FLAGS "${CXX_FLAGS}"
                       LINK_FLAGS      "${LINK_FLAGS}")
 target_link_libraries(${TARGET_NAME} ${LINK_LIBS})
 add_test(${TARGET_NAME}
          ${PYTHON_EXECUTABLE}
          ${CMAKE_CURRENT_SOURCE_DIR}/${PYTHON_SCRIPT})
 execute_process(COMMAND ${CMAKE_COMMAND} -E copy_if_different
                 ${CMAKE_CURRENT_SOURCE_DIR}/${PYTHON_SCRIPT} ${EXECUTABLE_OUTPUT_PATH})
endmacro(GTEST_PYTHON)
