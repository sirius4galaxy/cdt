configure_file(${CMAKE_CURRENT_SOURCE_DIR}/cdt-init.cpp ${CMAKE_BINARY_DIR}/flon-init.cpp @ONLY)

add_tool(flon-init)

set_target_properties(flon-init PROPERTIES LINK_FLAGS "-Wl,-rpath,\"\\$ORIGIN/../lib\"")
