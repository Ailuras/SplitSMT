# Simple Makefile for StrProcessor using CMake

.PHONY: all configure build debug clean help

CMAKE ?= cmake
BUILD_DIR ?= build
BUILD_TYPE ?= Release

all: build

configure:
	@echo "Configuring StrProcessor (${BUILD_TYPE})..."
	@$(CMAKE) -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE)
	@ln -sf $(BUILD_DIR)/compile_commands.json .

build: configure
	@echo "Building StrProcessor (${BUILD_TYPE})..."
	@$(CMAKE) --build $(BUILD_DIR)

debug:
	@$(MAKE) build BUILD_TYPE=Debug

clean:
	@echo "Cleaning build directory..."
	@$(CMAKE) --build $(BUILD_DIR) --target clean >/dev/null 2>&1 || true
	@rm -rf $(BUILD_DIR)
	@echo "Build directory removed."

help:
	@echo "StrProcessor Build System"
	@echo "========================"
	@echo ""
	@echo "Available targets:"
	@echo "  all      - Configure (if needed) and build in $(BUILD_TYPE)"
	@echo "  configure- Run CMake configure step"
	@echo "  build    - Build the project"
	@echo "  debug    - Build with Debug configuration"
	@echo "  clean    - Remove build artifacts"
	@echo "  help     - Show this help message"
