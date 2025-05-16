#!/bin/bash
set -e

echo "=== StrProcessor Build Script ==="
echo "Installing dependencies..."

# Check for required packages
if ! dpkg -s libgmp-dev libmpfr-dev libboost-system-dev cmake > /dev/null 2>&1; then
    echo "Installing required packages..."
    sudo apt-get update
    sudo apt-get install -y libgmp-dev libmpfr-dev libboost-system-dev cmake
fi

# Create build directory if it doesn't exist
mkdir -p build
cd build

# Configure with CMake
echo "Configuring with CMake..."
cmake .. -DCMAKE_BUILD_TYPE=Release

# Build with all available cores
echo "Building project..."
cmake --build . -- -j$(nproc)

# Return to root directory
cd ..

echo "Build completed successfully. Binary located at: build/bin/strprocessor"
echo "You can run it with: ./build/bin/strprocessor <input_file>" 