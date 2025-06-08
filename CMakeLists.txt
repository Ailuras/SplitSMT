cmake_minimum_required(VERSION 3.16)
project(StrProcessor)

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

# Set variables for SMTParser
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries" FORCE)
set(BUILD_BOTH_LIBS OFF CACHE BOOL "Build both static and shared libraries" FORCE)

# Add SMTParser as a subdirectory
add_subdirectory(external/SMTLIBParser)

# Print SMTParser status
message(STATUS "SMTParser include dirs: ${CMAKE_CURRENT_SOURCE_DIR}/external/SMTLIBParser/include")

# Add our source files
set(SOURCES
    src/main.cpp
    src/Context.cpp
    src/Structures.cpp
    src/Solver.cpp
    src/Split.cpp
)

# Set RPATH for runtime library search
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# Add runtime library paths
if(Z3_FOUND)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH};${Z3_ROOT}/build")
endif()

if(CVC5_FOUND)
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH};${CVC5_ROOT}/build/src")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH};${CVC5_ROOT}/build/src/parser")
    set(CMAKE_INSTALL_RPATH "${CMAKE_INSTALL_RPATH};${CVC5_ROOT}/build/deps/lib")
endif()

# Set RPATH for build tree
set(CMAKE_BUILD_RPATH "${CMAKE_INSTALL_RPATH}")

# Add executable
add_executable(strprocessor ${SOURCES})

# Add debug executable
add_executable(debug_strprocessor
    src/debug_main.cpp
    src/Context.cpp
    src/Structures.cpp
    src/Solver.cpp
    src/Split.cpp
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
    smtparser
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
    smtparser
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

# Generate wrapper script for easy execution
# configure_file(
#     "${CMAKE_CURRENT_SOURCE_DIR}/strprocessor_wrapper.sh.in"
#     "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/strprocessor_wrapper.sh"
#     @ONLY
# )

# Make wrapper script executable
# add_custom_command(TARGET strprocessor POST_BUILD
#     COMMAND chmod +x "${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/strprocessor_wrapper.sh"
#     COMMENT "Making wrapper script executable"
# )

# Print summary
message(STATUS "Build configuration:")
message(STATUS "  C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "  Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  SMTParser: Static Library")
message(STATUS "  Binary output: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/strprocessor")

# Add example copy command for testing
add_custom_command(TARGET strprocessor POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Build completed successfully"
)

option(ENABLE_Z3 "Enable Z3 solver support" ON)
option(ENABLE_CVC5 "Enable CVC5 solver support" ON)

set(Z3_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/external/z3")
set(CVC5_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/external/cvc5")

if(ENABLE_Z3)
    if(EXISTS "${Z3_ROOT}")
        set(Z3_INCLUDE_DIRS 
            "${Z3_ROOT}/src/api" 
            "${Z3_ROOT}/src/api/c++"
        )
        
        find_library(Z3_LIBRARY 
            NAMES z3 libz3
            PATHS "${Z3_ROOT}/build"
            NO_DEFAULT_PATH
        )
        
        if(Z3_LIBRARY AND EXISTS "${Z3_ROOT}/src/api/c++/z3++.h")
            set(Z3_FOUND TRUE)
            add_definitions(-DENABLE_Z3)
            message(STATUS "Z3 found at: ${Z3_ROOT}")
            message(STATUS "Z3 library: ${Z3_LIBRARY}")
            message(STATUS "Z3 include dirs: ${Z3_INCLUDE_DIRS}")
        else()
            message(WARNING "Z3 library or headers not found in ${Z3_ROOT}")
            set(ENABLE_Z3 OFF)
        endif()
    else()
        message(WARNING "Z3 directory not found: ${Z3_ROOT}")
        set(ENABLE_Z3 OFF)
    endif()
endif()

if(ENABLE_CVC5)
    if(EXISTS "${CVC5_ROOT}")
        set(CVC5_INCLUDE_DIRS 
            "${CVC5_ROOT}/include"
            "${CVC5_ROOT}/build/include"
        )
        
        find_library(CVC5_LIBRARY 
            NAMES cvc5 libcvc5
            PATHS "${CVC5_ROOT}/build/src"
            NO_DEFAULT_PATH
        )
        
        find_library(CVC5_PARSER_LIBRARY 
            NAMES cvc5parser libcvc5parser
            PATHS "${CVC5_ROOT}/build/src/parser"
            NO_DEFAULT_PATH
        )
        
        if(CVC5_LIBRARY AND EXISTS "${CVC5_ROOT}/include/cvc5/cvc5.h")
            set(CVC5_FOUND TRUE)
            add_definitions(-DENABLE_CVC5)
            message(STATUS "CVC5 found at: ${CVC5_ROOT}")
            message(STATUS "CVC5 library: ${CVC5_LIBRARY}")
            if(CVC5_PARSER_LIBRARY)
                message(STATUS "CVC5 parser library: ${CVC5_PARSER_LIBRARY}")
            endif()
            message(STATUS "CVC5 include dirs: ${CVC5_INCLUDE_DIRS}")
        else()
            message(WARNING "CVC5 library or headers not found in ${CVC5_ROOT}")
            set(ENABLE_CVC5 OFF)
        endif()
    else()
        message(WARNING "CVC5 directory not found: ${CVC5_ROOT}")
        set(ENABLE_CVC5 OFF)
    endif()
endif()

if(Z3_FOUND)
    target_include_directories(strprocessor PRIVATE ${Z3_INCLUDE_DIRS})
    target_include_directories(debug_strprocessor PRIVATE ${Z3_INCLUDE_DIRS})
    target_link_libraries(strprocessor PRIVATE ${Z3_LIBRARY})
    target_link_libraries(debug_strprocessor PRIVATE ${Z3_LIBRARY})
endif()

if(CVC5_FOUND)
    target_include_directories(strprocessor PRIVATE ${CVC5_INCLUDE_DIRS})
    target_include_directories(debug_strprocessor PRIVATE ${CVC5_INCLUDE_DIRS})
    target_link_libraries(strprocessor PRIVATE ${CVC5_LIBRARY})
    target_link_libraries(debug_strprocessor PRIVATE ${CVC5_LIBRARY})
    if(CVC5_PARSER_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${CVC5_PARSER_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${CVC5_PARSER_LIBRARY})
    endif()
    
    # Add additional RPATH for CVC5 dependencies at link time
    set_target_properties(strprocessor PROPERTIES
        LINK_FLAGS "-Wl,-rpath,${CVC5_ROOT}/build/deps/lib"
    )
    set_target_properties(debug_strprocessor PROPERTIES
        LINK_FLAGS "-Wl,-rpath,${CVC5_ROOT}/build/deps/lib"
    )
    
    find_library(CLN_LIBRARY NAMES cln libcln PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    find_library(COCOA_LIBRARY NAMES cocoa libcocoa PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    find_library(PICPOLY_LIBRARY NAMES poly libpoly PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    find_library(PICPOLYXX_LIBRARY NAMES polyxx libpolyxx PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    find_library(GLPK_LIBRARY NAMES glpk libglpk PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    find_library(CADICAL_LIBRARY NAMES cadical libcadical PATHS "${CVC5_ROOT}/build/deps/lib" NO_DEFAULT_PATH)
    
    if(CLN_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${CLN_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${CLN_LIBRARY})
        message(STATUS "CLN library: ${CLN_LIBRARY}")
    endif()
    
    if(COCOA_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${COCOA_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${COCOA_LIBRARY})
        message(STATUS "COCOA library: ${COCOA_LIBRARY}")
    endif()
    
    if(PICPOLY_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${PICPOLY_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${PICPOLY_LIBRARY})
        message(STATUS "PICPOLY library: ${PICPOLY_LIBRARY}")
    endif()
    
    if(PICPOLYXX_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${PICPOLYXX_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${PICPOLYXX_LIBRARY})
        message(STATUS "PICPOLYXX library: ${PICPOLYXX_LIBRARY}")
    endif()
    
    if(GLPK_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${GLPK_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${GLPK_LIBRARY})
        message(STATUS "GLPK library: ${GLPK_LIBRARY}")
    endif()
    
    if(CADICAL_LIBRARY)
        target_link_libraries(strprocessor PRIVATE ${CADICAL_LIBRARY})
        target_link_libraries(debug_strprocessor PRIVATE ${CADICAL_LIBRARY})
        message(STATUS "CADICAL library: ${CADICAL_LIBRARY}")
    endif()
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(strprocessor PRIVATE -g -O0)
    target_compile_options(debug_strprocessor PRIVATE -g -O0)
else()
    target_compile_options(strprocessor PRIVATE -O2)
    target_compile_options(debug_strprocessor PRIVATE -O2)
endif()

# Add simple clean target
add_custom_target(clean-project
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target clean
    COMMENT "Cleaning project build artifacts"
) 