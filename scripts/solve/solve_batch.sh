#!/bin/bash

# SMT-LIB Files Solver Script
# This script processes SMT-LIB files using run_strprocessor.sh
# Usage: solve_batch.sh [OPTIONS]

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
INPUT_DIR="benchmarks/seeds"
OUTPUT_DIR="results"
OUTPUT_FILE="solve_results.log"
SOLVER_SCRIPT="./run_strprocessor.sh"
TIMEOUT=30
TASK_NAME="solve"
SOLVER_TYPE="z3"

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

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "OPTIONS:"
    echo "  -i, --input-dir DIR     Input directory containing SMT-LIB files (default: benchmarks/seeds)"
    echo "  -o, --output-dir DIR    Output directory for results (default: results)"
    echo "  -f, --output-file FILE  Output file name (default: solve_results.log)"
    echo "  -s, --solver-script SCRIPT  Solver script path (default: ./run_strprocessor.sh)"
    echo "  --solver TYPE           Solver type (default: z3)"
    echo "                          Built-in solvers: z3, cvc5"
    echo "                          External solvers: ext-z3, ext-cvc5, ext-ostrich, ext-z3-noodler"
    echo "  -t, --timeout SEC       Timeout in seconds (default: 30)"
    echo "  -n, --task-name NAME    Task name for logging (default: solve)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 -i benchmarks/seeds -o results -t 60"
    echo "  $0 -i benchmarks/seeds --solver ext-ostrich -t 60"
    echo ""
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -i|--input-dir)
            INPUT_DIR="$2"
            shift 2
            ;;
        -o|--output-dir)
            OUTPUT_DIR="$2"
            shift 2
            ;;
        -f|--output-file)
            OUTPUT_FILE="$2"
            shift 2
            ;;
        -s|--solver-script)
            SOLVER_SCRIPT="$2"
            shift 2
            ;;
        --solver)
            SOLVER_TYPE="$2"
            shift 2
            ;;
        -t|--timeout)
            TIMEOUT="$2"
            shift 2
            ;;
        -n|--task-name)
            TASK_NAME="$2"
            shift 2
            ;;
        -h|--help)
            show_usage
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            show_usage
            exit 1
            ;;
    esac
done

# Function to print separators (similar to batch.sh)
print_double_separator() {
    echo "===========================================================" >> "$FULL_OUTPUT_PATH"
}

print_single_separator() {
    echo "-----------------------------------------------------------" >> "$FULL_OUTPUT_PATH"
}

# Main execution starts here
print_info "=== SMT-LIB Files Solver ==="
print_info "Input directory: $INPUT_DIR"
print_info "Output directory: $OUTPUT_DIR"
print_info "Output file: $OUTPUT_FILE"
print_info "Solver script: $SOLVER_SCRIPT"
print_info "Solver type: $SOLVER_TYPE"
print_info "Timeout: ${TIMEOUT}s"
print_info "Task name: $TASK_NAME"

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    print_error "Input directory does not exist: $INPUT_DIR"
    exit 1
fi

# Check if solver script exists
if [[ ! -f "$SOLVER_SCRIPT" ]]; then
    print_error "Solver script not found: $SOLVER_SCRIPT"
    exit 1
fi

# Make solver script executable
chmod +x "$SOLVER_SCRIPT"

# Create output directory
print_info "Creating output directory..."
mkdir -p "$OUTPUT_DIR"
if [[ $? -ne 0 ]]; then
    print_error "Failed to create output directory: $OUTPUT_DIR"
    exit 1
fi

# Set full output path
FULL_OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"

# Clear existing output file
: > "$FULL_OUTPUT_PATH"

# Find all SMT2 files
print_info "Scanning for SMT2 files in $INPUT_DIR..."
mapfile -t smt_files < <(find "$INPUT_DIR" -name "*.smt2" -type f | sort)

if [[ ${#smt_files[@]} -eq 0 ]]; then
    print_warning "No SMT2 files found in $INPUT_DIR"
    exit 0
fi

total_files=${#smt_files[@]}
print_info "Found $total_files SMT2 files"

# Initialize counters
success_count=0
timeout_count=0
error_count=0
sat_count=0
unsat_count=0
unknown_count=0

# Record overall start time
overall_start=$(date +%s.%N)

# Write header to output file
echo "========================================================" >> "$FULL_OUTPUT_PATH"
echo "SMT-LIB FILES SOLVING RESULTS" >> "$FULL_OUTPUT_PATH"
echo "Task: $TASK_NAME" >> "$FULL_OUTPUT_PATH"
echo "Solver Script: $(basename "$SOLVER_SCRIPT")" >> "$FULL_OUTPUT_PATH"
echo "Solver Type: $SOLVER_TYPE" >> "$FULL_OUTPUT_PATH"
echo "Timeout: ${TIMEOUT}s" >> "$FULL_OUTPUT_PATH"
echo "Total Files: $total_files" >> "$FULL_OUTPUT_PATH"
echo "Started: $(date)" >> "$FULL_OUTPUT_PATH"
echo "========================================================" >> "$FULL_OUTPUT_PATH"
echo "" >> "$FULL_OUTPUT_PATH"

# Process each file
file_index=0
for file in "${smt_files[@]}"; do
    file_index=$((file_index + 1))
    filename=$(basename "$file")
    
    print_info "[$file_index/$total_files] Processing: $filename"
    
    # Write file header (similar to batch.sh format)
    print_double_separator
    echo "FILE: $filename" >> "$FULL_OUTPUT_PATH"
    echo "PATH: $file" >> "$FULL_OUTPUT_PATH"
    echo "TASK: $TASK_NAME" >> "$FULL_OUTPUT_PATH"
    echo "SOLVER_SCRIPT: $(basename "$SOLVER_SCRIPT")" >> "$FULL_OUTPUT_PATH"
    echo "SOLVER_TYPE: $SOLVER_TYPE" >> "$FULL_OUTPUT_PATH"
    echo "TIMEOUT: ${TIMEOUT}s" >> "$FULL_OUTPUT_PATH"
    echo "INDEX: $file_index/$total_files" >> "$FULL_OUTPUT_PATH"
    print_single_separator
    
    # Record start time for this file
    start_time=$(date +%s.%N)
    
    # Create temporary file for solver output
    temp_output=$(mktemp)
    
    # Run the solver with timeout
    timeout "${TIMEOUT}s" "$SOLVER_SCRIPT" "$file" --solver "$SOLVER_TYPE" > "$temp_output" 2>&1
    exit_status=$?
    
    # Record end time
    end_time=$(date +%s.%N)
    
    # Calculate solving time
    solving_time=$(echo "$end_time - $start_time" | bc -l)
    
    # Write solver output to main file
    cat "$temp_output" >> "$FULL_OUTPUT_PATH"
    
    print_single_separator
    echo "SOLVING_TIME: $solving_time" >> "$FULL_OUTPUT_PATH"
    
    # Determine result based on exit status and output
    if [[ $exit_status -eq 124 ]] || [[ $exit_status -eq 137 ]]; then
        echo "RESULT: TIMEOUT" >> "$FULL_OUTPUT_PATH"
        timeout_count=$((timeout_count + 1))
        print_warning "[$file_index/$total_files] TIMEOUT: $filename"
    elif [[ $exit_status -eq 0 ]]; then
        echo "RESULT: SUCCESS" >> "$FULL_OUTPUT_PATH"
        success_count=$((success_count + 1))
        
        # Try to determine SAT/UNSAT/UNKNOWN from output (before deleting temp file)
        if grep -q "^sat$" "$temp_output" 2>/dev/null; then
            echo "SAT_RESULT: SAT" >> "$FULL_OUTPUT_PATH"
            sat_count=$((sat_count + 1))
            print_success "[$file_index/$total_files] SAT: $filename"
        elif grep -q "^unsat$" "$temp_output" 2>/dev/null; then
            echo "SAT_RESULT: UNSAT" >> "$FULL_OUTPUT_PATH"
            unsat_count=$((unsat_count + 1))
            print_success "[$file_index/$total_files] UNSAT: $filename"
        elif grep -q "^unknown$" "$temp_output" 2>/dev/null; then
            echo "SAT_RESULT: UNKNOWN" >> "$FULL_OUTPUT_PATH"
            unknown_count=$((unknown_count + 1))
            print_success "[$file_index/$total_files] UNKNOWN: $filename"
        else
            echo "SAT_RESULT: UNCLEAR" >> "$FULL_OUTPUT_PATH"
            print_success "[$file_index/$total_files] SUCCESS (unclear result): $filename"
        fi
    else
        echo "RESULT: ERROR" >> "$FULL_OUTPUT_PATH"
        echo "EXIT_CODE: $exit_status" >> "$FULL_OUTPUT_PATH"
        error_count=$((error_count + 1))
        print_error "[$file_index/$total_files] ERROR (exit $exit_status): $filename"
    fi
    
    # Clean up temp file (moved to after result checking)
    rm -f "$temp_output"
    
    echo "" >> "$FULL_OUTPUT_PATH"
done

# Calculate overall time
overall_end=$(date +%s.%N)
overall_duration=$(echo "$overall_end - $overall_start" | bc -l)

# Write summary to output file
print_double_separator
echo "SUMMARY" >> "$FULL_OUTPUT_PATH"
print_single_separator
echo "Total Files: $total_files" >> "$FULL_OUTPUT_PATH"
echo "Successful: $success_count" >> "$FULL_OUTPUT_PATH"
echo "Timeouts: $timeout_count" >> "$FULL_OUTPUT_PATH"
echo "Errors: $error_count" >> "$FULL_OUTPUT_PATH"
echo "SAT Results: $sat_count" >> "$FULL_OUTPUT_PATH"
echo "UNSAT Results: $unsat_count" >> "$FULL_OUTPUT_PATH"
echo "UNKNOWN Results: $unknown_count" >> "$FULL_OUTPUT_PATH"
echo "Total Time: ${overall_duration}s" >> "$FULL_OUTPUT_PATH"
echo "Average Time: $(echo "scale=3; $overall_duration / $total_files" | bc -l)s" >> "$FULL_OUTPUT_PATH"
echo "Completed: $(date)" >> "$FULL_OUTPUT_PATH"
print_double_separator

# Print final statistics to console
print_info "=== Solving Completed ==="
print_success "Total files processed: $total_files"
print_success "Successful: $success_count"
if [[ $timeout_count -gt 0 ]]; then
    print_warning "Timeouts: $timeout_count"
fi
if [[ $error_count -gt 0 ]]; then
    print_warning "Errors: $error_count"
fi
print_info "SAT: $sat_count, UNSAT: $unsat_count, UNKNOWN: $unknown_count"
print_info "Total time: $(printf "%.2f" "$overall_duration")s"
print_info "Average time: $(echo "scale=3; $overall_duration / $total_files" | bc -l)s per file"
print_info "Results saved in: $FULL_OUTPUT_PATH"

# Exit with appropriate code
if [[ $error_count -gt 0 ]]; then
    exit 1
else
    exit 0
fi 