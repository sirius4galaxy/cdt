configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-cc.cpp.in ${CMAKE_BINARY_DIR}/flon-cc.cpp)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-cpp.cpp.in ${CMAKE_BINARY_DIR}/flon-cpp.cpp)

add_tool(flon-cc)
add_tool(flon-cpp)

set_target_properties(flon-cc PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
set_target_properties(flon-cpp PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
