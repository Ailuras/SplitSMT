# StrProcessor

A C++ tool for processing SMT-LIB2 string expressions, built on SMTLIBParser.

## Requirements

- C++17 compatible compiler (GCC 7+, Clang 5+)
- CMake 3.10+
- GMP and MPFR libraries
- Boost System library

## Building

1. Make sure all dependencies are installed:

```bash
sudo apt-get install libgmp-dev libmpfr-dev libboost-system-dev cmake
```

2. Clone the repository with submodules:

```bash
git clone --recursive https://github.com/yourusername/StrProcessor.git
cd StrProcessor
```

3. Build using the provided script:

```bash
./build.sh
```

Or manually:

```bash
mkdir -p build && cd build
cmake ..
make -j$(nproc)
```

## Usage

```
./build/bin/strprocessor <input_file> [output_file] [-l <log_level>] [-t]
```

### Options:

- `<input_file>`: Required SMT-LIB2 input file
- `[output_file]`: Optional output file (if not provided, outputs to stdout)
- `-l, --level`: Set logging level (40=ERROR, 30=WARNING, 20=INFO [default], 15=DEBUG)
- `-t, --tree`: Enable tree-style output format

## Example

```bash
./build/bin/strprocessor examples/simple.smt2 output.smt2 -t
```

## Static Compilation with SMTLIBParser

This project uses the SMTLIBParser library as a static library to ensure portability. The SMTLIBParser is integrated as a CMake subdirectory and compiled together with the main project.

The key aspects of the integration are:

1. Setting static build options for SMTLIBParser:
```cmake
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries" FORCE)
set(BUILD_BOTH_LIBS OFF CACHE BOOL "Build both static and shared libraries" FORCE)
add_subdirectory(external/SMTLIBParser)
```

2. Linking to the static library:
```cmake
target_link_libraries(strprocessor PRIVATE
    smtlibparser
    ${Boost_LIBRARIES}
    ${GMP_LIBRARIES}
    ${MPFR_LIBRARIES}
)
```

3. Including SMTLIBParser headers:
```cmake
target_include_directories(strprocessor PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/src
    ${CMAKE_CURRENT_SOURCE_DIR}/external/SMTLIBParser/include
)
```

To update the SMTLIBParser to a newer version, replace the contents of the `external/SMTLIBParser` directory with the new version and rebuild.

## Project Structure

- `src/`: Source code for the main application
  - `main.cpp`: Entry point
  - `Parser.h/cpp`: SMT-LIB2 parsing functionality
  - `Logger.h`: Logging utilities
- `external/SMTLIBParser/`: External parser library
- `build/`: Generated build files (after running build script)
- `build/bin/`: Compiled executable

## License

[MIT License](LICENSE) 