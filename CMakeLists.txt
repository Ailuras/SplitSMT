cmake_minimum_required(VERSION 3.10)
project(StrProcessor VERSION 1.0.0 LANGUAGES CXX)

# Set C++ standard
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Define output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Find dependencies using pkg-config
find_package(PkgConfig REQUIRED)
pkg_check_modules(GMP REQUIRED gmp)
pkg_check_modules(MPFR REQUIRED mpfr)

# Find Boost
find_package(Boost REQUIRED COMPONENTS system)

# Set variables for SMTLIBParser
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries" FORCE)
set(BUILD_BOTH_LIBS OFF CACHE BOOL "Build both static and shared libraries" FORCE)

# Add SMTLIBParser as a subdirectory
add_subdirectory(external/SMTLIBParser)

# Print SMTLIBParser status
message(STATUS "SMTLIBParser include dirs: ${CMAKE_CURRENT_SOURCE_DIR}/external/SMTLIBParser/include")

# Add our source files
set(SOURCES
    src/Parser.cpp
    src/main.cpp
    src/Context.cpp
    src/Structures.cpp
)

# Add executable
add_executable(strprocessor ${SOURCES})

# Add debug executable
add_executable(debug_strprocessor
    src/debug_main.cpp
    src/Parser.cpp
    src/Context.cpp
    src/Structures.cpp
)

# Create compile_commands.json for IDE integration
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set include directories for our project
target_include_directories(strprocessor PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/external/SMTLIBParser/include
    ${Boost_INCLUDE_DIRS}
    ${GMP_INCLUDE_DIRS}
    ${MPFR_INCLUDE_DIRS}
)

# Link libraries
target_link_libraries(strprocessor PRIVATE
    smtlibparser
    ${Boost_LIBRARIES}
    ${GMP_LIBRARIES}
    ${MPFR_LIBRARIES}
)

# Set include directories for debug executable
target_include_directories(debug_strprocessor PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/external/SMTLIBParser/include
    ${Boost_INCLUDE_DIRS}
    ${GMP_INCLUDE_DIRS}
    ${MPFR_INCLUDE_DIRS}
)

# Link libraries for debug executable
target_link_libraries(debug_strprocessor PRIVATE
    smtlibparser
    ${Boost_LIBRARIES}
    ${GMP_LIBRARIES}
    ${MPFR_LIBRARIES}
)

# Add compile options
if(MSVC)
    target_compile_options(strprocessor PRIVATE /W4)
else()
    target_compile_options(strprocessor PRIVATE 
        -Wall 
        -Wextra 
        -Wpedantic
        -Wno-unused-value        # Ignore unused value warnings
        -Wno-deprecated-copy     # Ignore deprecated copy warnings
    )
endif()

# Install executable
install(TARGETS strprocessor
    RUNTIME DESTINATION bin
)

# Print summary
message(STATUS "Build configuration:")
message(STATUS "  C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "  Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  SMTLIBParser: Static Library")
message(STATUS "  Binary output: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/strprocessor")

# Add example copy command for testing
add_custom_command(TARGET strprocessor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Build completed successfully"
) 