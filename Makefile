# Simple Makefile for StrProcessor

.PHONY: all build clean help

# Default target
all: build

# Build the project
build:
	@echo "Building StrProcessor..."
	@./build.sh

# Clean build directory
clean:
	@echo "Cleaning build directory..."
	@rm -rf build
	@echo "Build directory removed."

# Show help
help:
	@echo "StrProcessor Build System"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@echo "  all    - Build the project (default)"
	@echo "  build  - Build the project using build.sh"
	@echo "  clean  - Remove build directory"
	@echo "  help   - Show this help message" 