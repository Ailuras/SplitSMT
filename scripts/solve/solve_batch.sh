#!/bin/bash

# SMT-LIB Files Solver Script
# This script processes SMT-LIB files using run_strprocessor.sh in parallel
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
NUM_PARALLEL=0

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
    echo "  -p, --parallel NUM      Number of parallel processes (default: number of CPU cores)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 -i benchmarks/seeds -o results -t 60"
    echo "  $0 -i benchmarks/seeds --solver ext-ostrich -t 60 -p 4"
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
        -p|--parallel)
            NUM_PARALLEL="$2"
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

# Set the number of parallel processes
if [ "$NUM_PARALLEL" -eq 0 ]; then
    NUM_PARALLEL=$(nproc)
fi

# Function to process a batch of files
process_batch() {
    local batch_id=$1
    local batch_output_file=$2
    shift 2
    local batch_files=("$@")
    
    local batch_success=0
    local batch_timeout=0
    local batch_error=0
    local batch_sat=0
    local batch_unsat=0
    local batch_unknown=0
    local batch_unclear=0
    
    # No batch header needed - keep log file clean
    
    local file_index=0
    for file in "${batch_files[@]}"; do
        file_index=$((file_index + 1))
        filename=$(basename "$file")
        
        # No individual file progress output
        
        # Write file header
        echo "===========================================================" >> "$batch_output_file"
        echo "FILE: $filename" >> "$batch_output_file"
        echo "PATH: $file" >> "$batch_output_file"
        echo "TASK: $TASK_NAME" >> "$batch_output_file"
        echo "SOLVER_SCRIPT: $(basename "$SOLVER_SCRIPT")" >> "$batch_output_file"
        echo "SOLVER_TYPE: $SOLVER_TYPE" >> "$batch_output_file"
        echo "TIMEOUT: ${TIMEOUT}s" >> "$batch_output_file"
        echo "BATCH: $batch_id" >> "$batch_output_file"
        echo "INDEX: $file_index/${#batch_files[@]}" >> "$batch_output_file"
        echo "-----------------------------------------------------------" >> "$batch_output_file"
        
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
        
        # Write solver output to batch file
        cat "$temp_output" >> "$batch_output_file"
        
        echo "-----------------------------------------------------------" >> "$batch_output_file"
        echo "SOLVING_TIME: $solving_time" >> "$batch_output_file"
        
        # Determine result based on exit status and output
        if [[ $exit_status -eq 124 ]] || [[ $exit_status -eq 137 ]]; then
            echo "RESULT: TIMEOUT" >> "$batch_output_file"
            batch_timeout=$((batch_timeout + 1))
            # Silent timeout handling
        elif [[ $exit_status -eq 0 ]]; then
            echo "RESULT: SUCCESS" >> "$batch_output_file"
            batch_success=$((batch_success + 1))
            
            # Check solver output more comprehensively
            if grep -q "^sat$" "$temp_output" 2>/dev/null; then
                echo "SAT_RESULT: SAT" >> "$batch_output_file"
                batch_sat=$((batch_sat + 1))
            elif grep -q "^unsat$" "$temp_output" 2>/dev/null; then
                echo "SAT_RESULT: UNSAT" >> "$batch_output_file"
                batch_unsat=$((batch_unsat + 1))
            elif grep -q "^unknown$" "$temp_output" 2>/dev/null; then
                echo "SAT_RESULT: UNKNOWN" >> "$batch_output_file"
                batch_unknown=$((batch_unknown + 1))
            elif grep -qE "^(sat|unsat|unknown)$" "$temp_output" 2>/dev/null; then
                # Handle case-insensitive or with extra whitespace
                result=$(grep -iE "^(sat|unsat|unknown)$" "$temp_output" 2>/dev/null | head -1 | tr '[:upper:]' '[:lower:]' | tr -d ' ')
                if [[ "$result" == "sat" ]]; then
                    echo "SAT_RESULT: SAT" >> "$batch_output_file"
                    batch_sat=$((batch_sat + 1))
                elif [[ "$result" == "unsat" ]]; then
                    echo "SAT_RESULT: UNSAT" >> "$batch_output_file"
                    batch_unsat=$((batch_unsat + 1))
                elif [[ "$result" == "unknown" ]]; then
                    echo "SAT_RESULT: UNKNOWN" >> "$batch_output_file"
                    batch_unknown=$((batch_unknown + 1))
                else
                    echo "SAT_RESULT: UNCLEAR" >> "$batch_output_file"
                    batch_unclear=$((batch_unclear + 1))
                fi
            else
                echo "SAT_RESULT: UNCLEAR" >> "$batch_output_file"
                batch_unclear=$((batch_unclear + 1))
            fi
        else
            echo "RESULT: ERROR" >> "$batch_output_file"
            echo "EXIT_CODE: $exit_status" >> "$batch_output_file"
            batch_error=$((batch_error + 1))
            # Silent error handling
        fi
        
        # Clean up temp file
        rm -f "$temp_output"
        
        echo "" >> "$batch_output_file"
    done
    
    # No batch summary needed - keep log file clean
    
    print_info "[Batch $batch_id] Completed: ${#batch_files[@]} files processed"
}

# Main execution starts here
print_info "=== SMT-LIB Files Parallel Solver ==="
print_info "Input directory: $INPUT_DIR"
print_info "Output directory: $OUTPUT_DIR"
print_info "Output file: $OUTPUT_FILE"
print_info "Solver script: $SOLVER_SCRIPT"
print_info "Solver type: $SOLVER_TYPE"
print_info "Timeout: ${TIMEOUT}s"
print_info "Parallel processes: $NUM_PARALLEL"
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

# Find all SMT2 files
print_info "Scanning for SMT2 files in $INPUT_DIR..."
mapfile -t smt_files < <(find "$INPUT_DIR" -name "*.smt2" -type f | sort)

if [[ ${#smt_files[@]} -eq 0 ]]; then
    print_warning "No SMT2 files found in $INPUT_DIR"
    exit 0
fi

total_files=${#smt_files[@]}
print_info "Found $total_files SMT2 files"

# Calculate batch size
batch_size=$(( (total_files + NUM_PARALLEL - 1) / NUM_PARALLEL ))
if [[ $batch_size -eq 0 ]]; then
    batch_size=1
fi

print_info "Files per batch: $batch_size"

# Create temporary directory for batch files
TEMP_DIR_NAME="${OUTPUT_FILE%.*}_batches"
TEMP_BATCH_DIR="$OUTPUT_DIR/$TEMP_DIR_NAME"
mkdir -p "$TEMP_BATCH_DIR"
print_info "Created temporary batch directory: $TEMP_BATCH_DIR"

# Record overall start time
overall_start=$(date +%s.%N)

# Process files in parallel batches
print_info "Starting parallel processing with $NUM_PARALLEL processes..."

declare -a PIDS
declare -a BATCH_FILES

for ((i=0; i<NUM_PARALLEL; i++)); do
    # Calculate start and end indices for this batch
    start=$((i * batch_size))
    end=$(( (i+1) * batch_size - 1 ))
    
    # Ensure end index doesn't exceed total files
    if [[ $end -ge $total_files ]]; then
        end=$((total_files - 1))
    fi
    
    # Skip empty batches
    if [[ $start -gt $end ]]; then
        continue
    fi
    
    # Create a list of files for this batch
    batch_files_for_process=()
    for ((j=start; j<=end; j++)); do
        batch_files_for_process+=("${smt_files[j]}")
    done
    
    # Create batch output file in temporary directory
    batch_output="$TEMP_BATCH_DIR/batch_${i}.log"
    BATCH_FILES[i]="$batch_output"
    
    # Clear batch output file
    : > "$batch_output"
    
    # Run batch processing in background
    process_batch "$i" "$batch_output" "${batch_files_for_process[@]}" &
    PIDS[i]=$!
    
    print_info "Started batch $i with ${#batch_files_for_process[@]} files (PID: ${PIDS[i]})"
done

# Wait for all processes to complete
print_info "Waiting for all batches to complete..."
for pid in "${PIDS[@]}"; do
    if [[ -n "$pid" ]]; then
        wait "$pid"
    fi
done

print_info "All batches completed. Merging results..."

# Set full output path
FULL_OUTPUT_PATH="$OUTPUT_DIR/$OUTPUT_FILE"
: > "$FULL_OUTPUT_PATH"

# Initialize global counters
success_count=0
timeout_count=0
error_count=0
sat_count=0
unsat_count=0
unknown_count=0
unclear_count=0

# Calculate overall time
overall_end=$(date +%s.%N)
overall_duration=$(echo "$overall_end - $overall_start" | bc -l)

# No main header needed - keep log file clean, only individual file results

# Merge all batch files directly (no filtering needed since we removed batch summaries)
for batch_file in "${BATCH_FILES[@]}"; do
    if [[ -f "$batch_file" ]]; then
        cat "$batch_file" >> "$FULL_OUTPUT_PATH"
    fi
done

# Extract statistics directly from the merged log file
success_count=$(grep -c "RESULT: SUCCESS" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$success_count" ]]; then success_count=0; fi

timeout_count=$(grep -c "RESULT: TIMEOUT" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$timeout_count" ]]; then timeout_count=0; fi

error_count=$(grep -c "RESULT: ERROR" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$error_count" ]]; then error_count=0; fi

sat_count=$(grep -c "SAT_RESULT: SAT" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$sat_count" ]]; then sat_count=0; fi

unsat_count=$(grep -c "SAT_RESULT: UNSAT" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$unsat_count" ]]; then unsat_count=0; fi

unknown_count=$(grep -c "SAT_RESULT: UNKNOWN" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$unknown_count" ]]; then unknown_count=0; fi

unclear_count=$(grep -c "SAT_RESULT: UNCLEAR" "$FULL_OUTPUT_PATH" 2>/dev/null)
if [[ -z "$unclear_count" ]]; then unclear_count=0; fi

# Clean up temporary batch directory
print_info "Cleaning up temporary batch directory: $TEMP_BATCH_DIR"
rm -rf "$TEMP_BATCH_DIR"

# No final summary in log file - keep it clean

# Verification: Check if totals add up
calculated_total=$((success_count + timeout_count + error_count))
if [[ $calculated_total -ne $total_files ]]; then
    print_warning "Statistics mismatch! Calculated: $calculated_total, Expected: $total_files"
fi

success_breakdown=$((sat_count + unsat_count + unknown_count + unclear_count))
if [[ $success_breakdown -ne $success_count ]]; then
    print_warning "Success breakdown mismatch! Sum: $success_breakdown, Expected: $success_count"
fi

# Print final statistics to console
print_info "=== Parallel Solving Completed ==="
print_success "Total files processed: $total_files"
print_success "Successful: $success_count"
if [[ $timeout_count -gt 0 ]]; then
    print_warning "Timeouts: $timeout_count"
fi
if [[ $error_count -gt 0 ]]; then
    print_warning "Errors: $error_count"
fi
print_info "SAT: $sat_count, UNSAT: $unsat_count, UNKNOWN: $unknown_count, UNCLEAR: $unclear_count"
print_info "Parallel processes: $NUM_PARALLEL"
print_info "Total time: $(printf "%.2f" "$overall_duration")s"
print_info "Average time: $(echo "scale=3; $overall_duration / $total_files" | bc -l)s per file"
print_info "Results saved in: $FULL_OUTPUT_PATH"

# Generate Excel analysis report
print_info "Generating Excel analysis report..."
ANALYSIS_SCRIPT="scripts/solve/simple_analysis.py"

# Create charts directory
mkdir -p "charts"

if [[ -f "$ANALYSIS_SCRIPT" ]]; then
    python3 "$ANALYSIS_SCRIPT" --log-file "$FULL_OUTPUT_PATH" --output-dir "charts" --task-name "$TASK_NAME"
else
    print_warning "Analysis script not found: $ANALYSIS_SCRIPT"
fi

# Exit with appropriate code
# Only exit with error if a significant portion of files failed
# or if the script itself encountered critical issues
error_rate=$(echo "scale=2; $error_count * 100 / $total_files" | bc -l)
critical_error_threshold=50  # Exit with error if >50% of files failed

if [[ $total_files -eq 0 ]]; then
    print_error "No files were processed"
    exit 1
elif (( $(echo "$error_rate > $critical_error_threshold" | bc -l) )); then
    print_error "High error rate: ${error_rate}% of files failed"
    exit 1
else
    # Consider it successful if most files were processed
    if [[ $error_count -gt 0 ]]; then
        print_warning "Completed with ${error_count} errors (${error_rate}% error rate)"
    fi
    exit 0
fi 