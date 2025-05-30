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

# Set up environment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:${LD_LIBRARY_PATH}"

echo "Build completed successfully. Binary located at: build/bin/strprocessor"
echo ""
echo "Environment variables set for current session:"
echo "export LD_LIBRARY_PATH=\"${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:\${LD_LIBRARY_PATH}\""
echo ""

# Create a run script for convenience
cat > run_strprocessor.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:${LD_LIBRARY_PATH}"
exec "${SCRIPT_DIR}/build/bin/strprocessor" "$@"
EOF

chmod +x run_strprocessor.sh

# Create a debug run script
cat > run_debug.sh << 'EOF'
#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export LD_LIBRARY_PATH="${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:${LD_LIBRARY_PATH}"
exec "${SCRIPT_DIR}/build/bin/debug_strprocessor" "$@"
EOF

chmod +x run_debug.sh

echo "Created convenience scripts:"
echo "  ./run_strprocessor.sh <input_file> [options] - Run main program"
echo "  ./run_debug.sh - Run debug program"
echo ""
echo "You can also run directly with:"
echo "  LD_LIBRARY_PATH=\"${SCRIPT_DIR}/external/cvc5/build/deps/lib:${SCRIPT_DIR}/external/z3/build:\${LD_LIBRARY_PATH}\" ./build/bin/strprocessor <input_file>" 