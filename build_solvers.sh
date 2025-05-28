#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTERNAL_DIR="${SCRIPT_DIR}/external"

echo "Building solvers in ${EXTERNAL_DIR}"

build_z3() {
    echo "Building Z3..."
    cd "${EXTERNAL_DIR}/z3"
    
    if [ -d "build" ]; then
        echo "Removing existing Z3 build directory..."
        rm -rf build
    fi
    
    mkdir -p build
    cd build
    
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DZ3_BUILD_LIBZ3_SHARED=OFF \
          -DZ3_BUILD_PYTHON_BINDINGS=OFF \
          -DZ3_BUILD_DOTNET_BINDINGS=OFF \
          -DZ3_BUILD_JAVA_BINDINGS=OFF \
          -DZ3_ENABLE_EXAMPLE_TARGETS=OFF \
          ..
    
    make -j$(nproc)
    
    echo "Z3 built successfully!"
    echo "Library location: ${EXTERNAL_DIR}/z3/build/libz3.a"
    echo "Headers location: ${EXTERNAL_DIR}/z3/src/api/"
}

build_cvc5() {
    echo "Building CVC5..."
    cd "${EXTERNAL_DIR}/cvc5"
    
    if [ -d "build" ]; then
        echo "Removing existing CVC5 build directory..."
        rm -rf build
    fi
    
    ./configure.sh --static --auto-download
    
    cd build
    make -j$(nproc)
    
    echo "CVC5 built successfully!"
    echo "Library location: ${EXTERNAL_DIR}/cvc5/build/lib/libcvc5.a"
    echo "Headers location: ${EXTERNAL_DIR}/cvc5/include/"
}

check_dependencies() {
    echo "Checking dependencies..."
    
    if ! command -v cmake &> /dev/null; then
        echo "Error: cmake is required but not installed."
        exit 1
    fi
    
    if ! command -v make &> /dev/null; then
        echo "Error: make is required but not installed."
        exit 1
    fi
    
    echo "Dependencies check passed."
}

main() {
    check_dependencies
    
    echo "Choose which solvers to build:"
    echo "1) Z3 only"
    echo "2) CVC5 only"
    echo "3) Both Z3 and CVC5"
    echo "4) Exit"
    
    read -p "Enter your choice (1-4): " choice
    
    case $choice in
        1)
            build_z3
            ;;
        2)
            build_cvc5
            ;;
        3)
            build_z3
            build_cvc5
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Exiting..."
            exit 1
            ;;
    esac
    
    echo ""
    echo "Build completed! You can now compile your project with solver support."
    echo "Use: mkdir build && cd build && cmake .. && make"
}

main "$@" 