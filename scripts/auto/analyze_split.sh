#!/bin/bash

# SMT-LIB Split Function Call Analysis Helper Script
# This script analyzes split function calls in SMT files

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
INPUT_DIRS=("benchmarks/awesome" "benchmarks/top20_maven" "benchmarks/top20_gh")
OUTPUT_REPORT="split_analysis_report.txt"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ANALYZER_SCRIPT="$SCRIPT_DIR/analyze_split_calls.py"

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
    echo "  -i, --input-dirs DIR1 DIR2... Input directories containing SMT files"
    echo "                               (default: benchmarks/awesome benchmarks/top20_maven benchmarks/top20_gh)"
    echo "  -o, --output-report FILE     Output file for detailed report"
    echo "                               (default: split_analysis_report.txt)"
    echo "  -h, --help                   Show this help message"
    echo ""
    echo "Example:"
    echo "  $0"
    echo "  $0 -i benchmarks/awesome benchmarks/top20_maven -o my_report.txt"
    echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input-dirs)
            INPUT_DIRS=()
            shift
            while [[ $# -gt 0 && $1 != -* ]]; do
                INPUT_DIRS+=("$1")
                shift
            done
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

# Check if any input directories exist
dirs_exist=false
for dir in "${INPUT_DIRS[@]}"; do
    if [[ -d "$dir" ]]; then
        dirs_exist=true
        break
    fi
done

if [[ "$dirs_exist" == false ]]; then
    print_warning "None of the specified input directories exist:"
    for dir in "${INPUT_DIRS[@]}"; do
        print_warning "  $dir"
    done
    exit 1
fi

# Check if analyzer script exists
if [[ ! -f "$ANALYZER_SCRIPT" ]]; then
    print_warning "Analyzer script not found: $ANALYZER_SCRIPT"
    exit 1
fi

# Make analyzer script executable
chmod +x "$ANALYZER_SCRIPT"

print_info "=== SMT-LIB Split Function Call Analysis ==="
print_info "Input directories: ${INPUT_DIRS[*]}"
print_info "Output report: $OUTPUT_REPORT"
print_info "Analyzer script: $ANALYZER_SCRIPT"

# Build command arguments
cmd_args=("--input-dirs" "${INPUT_DIRS[@]}")
if [[ -n "$OUTPUT_REPORT" ]]; then
    cmd_args+=("--output-report" "$OUTPUT_REPORT")
fi

# Run the analysis
print_info "Starting analysis..."
python3 "$ANALYZER_SCRIPT" "${cmd_args[@]}"

if [[ $? -eq 0 ]]; then
    print_success "Analysis completed successfully!"
    if [[ -n "$OUTPUT_REPORT" ]]; then
        print_info "Detailed report saved to: $OUTPUT_REPORT"
    fi
    print_info ""
    print_info "You can now use the LaTeX table format shown above in your paper."
else
    print_warning "Analysis completed with errors"
    exit 1
fi 