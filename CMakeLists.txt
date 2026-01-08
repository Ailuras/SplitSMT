cmake_minimum_required(VERSION 3.16)
project(StrProcessor)

# Set C++ standard
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

# Create compile_commands.json for IDE integration
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Define output directories
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)

# Find dependencies using pkg-config
find_package(PkgConfig REQUIRED)
pkg_check_modules(GMP REQUIRED gmp)
pkg_check_modules(MPFR REQUIRED mpfr)

list(REMOVE_DUPLICATES GMP_LIBRARIES)
list(REMOVE_DUPLICATES MPFR_LIBRARIES)
list(REMOVE_DUPLICATES GMP_LIBRARY_DIRS)
list(REMOVE_DUPLICATES MPFR_LIBRARY_DIRS)

# Boost is no longer required after migration to STL containers

# Set variables for SMTParser
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries" FORCE)
set(BUILD_BOTH_LIBS OFF CACHE BOOL "Build both static and shared libraries" FORCE)

# Determine solver platform subdirectory
set(STRP_SOLVER_PLATFORM_SUBDIR "")
if(CMAKE_SYSTEM_NAME STREQUAL "Darwin")
    set(STRP_SOLVER_PLATFORM_SUBDIR "macos")
elseif(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(STRP_SOLVER_PLATFORM_SUBDIR "linux")
elseif(WIN32)
    set(STRP_SOLVER_PLATFORM_SUBDIR "windows")
endif()

if(STRP_SOLVER_PLATFORM_SUBDIR)
    message(STATUS "Configuring solver directory for platform: ${STRP_SOLVER_PLATFORM_SUBDIR}")
endif()

set(STRP_SOLVER_BASE_DIR "${CMAKE_SOURCE_DIR}/solvers")

# Add SMTParser as a subdirectory
add_subdirectory(src/SMTParser)

# Print SMTParser status
message(STATUS "SMTParser include dirs: ${CMAKE_CURRENT_SOURCE_DIR}/src/SMTParser/include")

# Core sources shared by executables
set(CORE_SOURCES
    src/core/Context.cpp
    src/core/Structures.cpp
    src/core/Solver.cpp
    src/core/Split.cpp
    src/core/check.cpp
    src/core/Fallback.cpp
    src/parser/Parser.cpp
    src/utils/RegexHelper.cpp
    src/utils/StringHelper.cpp
)

# Add our source files
set(SOURCES
    src/Main.cpp
    ${CORE_SOURCES}
)

# Set RPATH defaults
set(CMAKE_SKIP_BUILD_RPATH FALSE)
set(CMAKE_BUILD_WITH_INSTALL_RPATH FALSE)
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH TRUE)

# Add executable
add_executable(SplitSMT ${SOURCES})

# Add debug executable
add_executable(SplitSMT_debug
    src/Debug.cpp
    ${CORE_SOURCES}
)


# Set include directories for our project
target_include_directories(SplitSMT PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/SMTParser/include
    ${GMP_INCLUDE_DIRS}
    ${MPFR_INCLUDE_DIRS}
)

# Link libraries
target_link_libraries(SplitSMT PRIVATE
    smtparser
)

target_link_directories(SplitSMT PRIVATE
    ${GMP_LIBRARY_DIRS}
    ${MPFR_LIBRARY_DIRS}
)

target_compile_definitions(SplitSMT PRIVATE
    STRP_PROJECT_ROOT="${CMAKE_SOURCE_DIR}"
    STRP_DEFAULT_SOLVER_DIR="${STRP_SOLVER_BASE_DIR}"
)

if(STRP_SOLVER_PLATFORM_SUBDIR)
    target_compile_definitions(SplitSMT PRIVATE
        STRP_SOLVER_PLATFORM_SUBDIR="${STRP_SOLVER_PLATFORM_SUBDIR}"
    )
endif()

# Set include directories for debug executable
target_include_directories(SplitSMT_debug PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/src/SMTParser/include
    ${GMP_INCLUDE_DIRS}
    ${MPFR_INCLUDE_DIRS}
)

# Link libraries for debug executable
target_link_libraries(SplitSMT_debug PRIVATE
    smtparser
)

target_link_directories(SplitSMT_debug PRIVATE
    ${GMP_LIBRARY_DIRS}
    ${MPFR_LIBRARY_DIRS}
)

target_compile_definitions(SplitSMT_debug PRIVATE
    STRP_PROJECT_ROOT="${CMAKE_SOURCE_DIR}"
    STRP_DEFAULT_SOLVER_DIR="${STRP_SOLVER_BASE_DIR}"
)

if(STRP_SOLVER_PLATFORM_SUBDIR)
    target_compile_definitions(SplitSMT_debug PRIVATE
        STRP_SOLVER_PLATFORM_SUBDIR="${STRP_SOLVER_PLATFORM_SUBDIR}"
    )
endif()

# Add compile options
if(MSVC)
    target_compile_options(SplitSMT PRIVATE /W4)
else()
    target_compile_options(SplitSMT PRIVATE 
        -Wall 
        -Wextra 
        -Wpedantic
        -Wno-unused-value        # Ignore unused value warnings
        -Wno-deprecated-copy     # Ignore deprecated copy warnings
    )
endif()

# Install executable
install(TARGETS SplitSMT
    RUNTIME DESTINATION bin
)



# Print summary
message(STATUS "Build configuration:")
message(STATUS "  C++ standard: ${CMAKE_CXX_STANDARD}")
message(STATUS "  Compiler: ${CMAKE_CXX_COMPILER_ID} ${CMAKE_CXX_COMPILER_VERSION}")
message(STATUS "  Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "  SMTParser: Static Library")
message(STATUS "  Binary output: ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}/SplitSMT")

# Add example copy command for testing
add_custom_command(TARGET SplitSMT POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E echo "Build completed successfully"
)


if(CMAKE_BUILD_TYPE STREQUAL "Debug")
    target_compile_options(SplitSMT PRIVATE -g -O0)
    target_compile_options(SplitSMT_debug PRIVATE -g -O0)
else()
    target_compile_options(SplitSMT PRIVATE -O2)
    target_compile_options(SplitSMT_debug PRIVATE -O2)
endif()

# Add simple clean target
add_custom_target(clean-project
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --target clean
    COMMENT "Cleaning project build artifacts"
) 
