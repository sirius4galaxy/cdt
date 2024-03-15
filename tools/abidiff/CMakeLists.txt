configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-abidiff.cpp.in ${CMAKE_BINARY_DIR}/flon-abidiff.cpp)

add_tool(flon-abidiff)

set_target_properties(flon-abidiff PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
