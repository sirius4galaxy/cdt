configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-ld.cpp.in ${CMAKE_BINARY_DIR}/flon-ld.cpp)

add_tool(flon-ld)

set_target_properties(flon-ld PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
