#!/bin/bash

# SMT-LIB Mutation Analysis Helper Script
# This script runs the mutation analysis on generated files

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
INPUT_DIR="benchmarks/seeds_mutated_auto"
OUTPUT_REPORT="mutation_analysis_report.txt"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANALYZER_SCRIPT="$SCRIPT_DIR/analyze_mutations.py"

# Function to print colored output
print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -i, --input-dir DIR     Input directory containing mutated SMT files"
    echo "                          (default: benchmarks/seeds_mutated_auto)"
    echo "  -o, --output-report FILE Output file for detailed report"
    echo "                          (default: mutation_analysis_report.txt)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Example:"
    echo "  $0"
    echo "  $0 -i benchmarks/seeds_mutated_auto -o my_report.txt"
    echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input-dir)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output-report)
            OUTPUT_REPORT="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            echo "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    print_warning "Input directory does not exist: $INPUT_DIR"
    print_info "Please run the mutation script first to generate test files"
    exit 1
fi

# Check if analyzer script exists
if [[ ! -f "$ANALYZER_SCRIPT" ]]; then
    print_warning "Analyzer script not found: $ANALYZER_SCRIPT"
    exit 1
fi

# Make analyzer script executable
chmod +x "$ANALYZER_SCRIPT"

print_info "=== SMT-LIB Mutation Analysis ==="
print_info "Input directory: $INPUT_DIR"
print_info "Output report: $OUTPUT_REPORT"
print_info "Analyzer script: $ANALYZER_SCRIPT"

# Run the analysis
print_info "Starting analysis..."
python3 "$ANALYZER_SCRIPT" --input-dir "$INPUT_DIR" --output-report "$OUTPUT_REPORT"

if [[ $? -eq 0 ]]; then
    print_success "Analysis completed successfully!"
    print_info "Detailed report saved to: $OUTPUT_REPORT"
    print_info ""
    print_info "You can now use the LaTeX table format shown above in your paper."
else
    print_warning "Analysis completed with errors"
    exit 1
fi 