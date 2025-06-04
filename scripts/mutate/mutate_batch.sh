#!/bin/bash

# Batch Mutation Script
# This script mutates all SMT-LIB files using different mutation strategies:
# - auto: Rule-based automatic mutation
# - openai, claude, deepseek: LLM-based mutation
# Results are saved to provider-specific directories (e.g., seeds_mutate_auto)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Default values
INPUT_DIR="benchmarks/seeds"
OUTPUT_DIR=""  # Will be set based on provider
MUTATOR_SCRIPT=""  # Will be set based on provider
PARALLEL_JOBS=4
PROVIDER="auto"
MODEL=""

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
    echo "  -i, --input-dir DIR     Input directory containing seed files (default: benchmarks/seeds)"
    echo "  -o, --output-dir DIR    Output directory for mutated files (auto-generated if not specified)"
    echo "  -p, --provider NAME     LLM provider to use: openai, claude, deepseek (default: auto)"
    echo "  -m, --model NAME        Specific model to use (optional, uses provider default)"
    echo "  -j, --jobs NUM          Number of parallel jobs (default: 4)"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0                                        # Use auto mutation (default)"
    echo "  $0 -p auto -j 8                          # Use auto mutation with 8 jobs"
    echo "  $0 -p deepseek -j 8                      # Generate seeds_mutate_deepseek with 8 jobs"
    echo "  $0 -p claude -m claude-3-haiku-20240307  # Use specific Claude model"
    echo "  $0 -i custom/seeds -o custom/output -p openai  # Custom directories"
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
        -p|--provider)
            PROVIDER="$2"
            shift 2
            ;;
        -m|--model)
            MODEL="$2"
            shift 2
            ;;
        -j|--jobs)
            PARALLEL_JOBS="$2"
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

# Set default output directory based on provider if not specified
if [[ -z "$OUTPUT_DIR" ]]; then
    OUTPUT_DIR="benchmarks/seeds_mutate_${PROVIDER}"
fi

# Set mutator script based on provider
case "$PROVIDER" in
    auto)
        MUTATOR_SCRIPT="scripts/mutate/mutate_auto.py"
        ;;
    openai|claude|deepseek)
        MUTATOR_SCRIPT="scripts/mutate/mutate_llm.py"
        ;;
    *)
        print_error "Invalid provider: $PROVIDER. Supported providers: auto, openai, claude, deepseek"
        exit 1
        ;;
esac

# Function to mutate a single file
mutate_file() {
    local input_file="$1"
    local output_file="$2"
    local file_index="$3"
    local total_files="$4"
    
    local filename=$(basename "$input_file")
    local base_name="${filename%.smt2}"
    local mutated_name="${base_name}.smt2"
    local final_output="$output_file"
    
    print_info "[$file_index/$total_files] Mutating: $filename -> $mutated_name (provider: $PROVIDER)"
    
    # Prepare mutator command based on provider
    local cmd
    if [[ "$PROVIDER" == "auto" ]]; then
        # For auto mutation, use random seed for each file
        local seed=$(( RANDOM * file_index ))
        cmd="python \"$MUTATOR_SCRIPT\" --input \"$input_file\" --output \"$final_output\" --seed $seed"
    else
        # For LLM mutations
        cmd="python \"$MUTATOR_SCRIPT\" --input \"$input_file\" --output \"$final_output\" --provider \"$PROVIDER\""
        
        # Add model parameter if specified
        if [[ -n "$MODEL" ]]; then
            cmd="$cmd --model \"$MODEL\""
        fi
    fi
    
    # Run the mutator
    if eval "$cmd" > /dev/null 2>&1; then
        if [[ -f "$final_output" ]]; then
            print_success "[$file_index/$total_files] Completed: $mutated_name"
            return 0
        else
            print_error "[$file_index/$total_files] Output file not created: $mutated_name"
            return 1
        fi
    else
        print_error "[$file_index/$total_files] Failed to mutate: $filename"
        return 1
    fi
}

# Main execution starts here
print_info "=== SMT-LIB Batch Mutator ==="
print_info "Input directory: $INPUT_DIR"
print_info "Output directory: $OUTPUT_DIR"
print_info "Mutation Provider: $PROVIDER"
if [[ -n "$MODEL" && "$PROVIDER" != "auto" ]]; then
    print_info "Model: $MODEL"
fi
print_info "Parallel jobs: $PARALLEL_JOBS"

# Check if input directory exists
if [[ ! -d "$INPUT_DIR" ]]; then
    print_error "Input directory does not exist: $INPUT_DIR"
    exit 1
fi

# Check if mutator script exists
if [[ ! -f "$MUTATOR_SCRIPT" ]]; then
    print_error "Mutator script not found: $MUTATOR_SCRIPT"
    exit 1
fi

# Create output directory
print_info "Creating output directory..."
if [[ -d "$OUTPUT_DIR" ]]; then
    print_warning "Output directory exists, clearing contents: $OUTPUT_DIR"
    rm -rf "$OUTPUT_DIR"
fi
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

print_info "Found ${#smt_files[@]} SMT2 files"

# Statistics
total_files=${#smt_files[@]}
success_count=0
failed_count=0
start_time=$(date +%s)

# Create a temporary file for job control
temp_dir=$(mktemp -d)
job_queue="$temp_dir/job_queue"
results_file="$temp_dir/results"

# Initialize results file
echo "0 0" > "$results_file"  # success_count failed_count

# Function to run mutations in parallel
run_parallel_mutations() {
    local job_count=0
    local file_index=0
    
    for input_file in "${smt_files[@]}"; do
        file_index=$((file_index + 1))
        filename=$(basename "$input_file")
        base_name="${filename%.smt2}"
        output_file="$OUTPUT_DIR/${base_name}.smt2"
        
        # Wait if we have too many background jobs
        while [[ $(jobs -r | wc -l) -ge $PARALLEL_JOBS ]]; do
            sleep 0.1
        done
        
        # Run mutation in background
        (
            if mutate_file "$input_file" "$output_file" "$file_index" "$total_files"; then
                # Update success count atomically
                (
                    flock -x 200
                    read success failed < "$results_file"
                    echo "$((success + 1)) $failed" > "$results_file"
                ) 200>"$results_file.lock"
            else
                # Update failed count atomically
                (
                    flock -x 200
                    read success failed < "$results_file"
                    echo "$success $((failed + 1))" > "$results_file"
                ) 200>"$results_file.lock"
            fi
        ) &
        
        job_count=$((job_count + 1))
    done
    
    # Wait for all background jobs to complete
    print_info "Waiting for all mutations to complete..."
    wait
}

# Execute parallel mutations
print_info "Starting batch mutation with $PARALLEL_JOBS parallel jobs..."
run_parallel_mutations

# Read final results
read success_count failed_count < "$results_file"

# Calculate timing
end_time=$(date +%s)
duration=$((end_time - start_time))

# Cleanup
rm -rf "$temp_dir"

# Print final statistics
print_info "=== Batch Mutation Completed ==="
print_success "Provider used: $PROVIDER"
if [[ -n "$MODEL" && "$PROVIDER" != "auto" ]]; then
    print_success "Model used: $MODEL"
fi
print_success "Total files processed: $total_files"
print_success "Successfully mutated: $success_count"
if [[ $failed_count -gt 0 ]]; then
    print_warning "Failed mutations: $failed_count"
fi
print_info "Total time: ${duration}s"
if [[ $total_files -gt 0 ]]; then
    print_info "Average time per file: $((duration * 1000 / total_files))ms"
fi
print_info "Results saved in: $OUTPUT_DIR"

# Show some examples of generated files
print_info "=== Sample Generated Files ==="
generated_files=($(find "$OUTPUT_DIR" -name "*.smt2" | head -5))
for file in "${generated_files[@]}"; do
    echo "  $(basename "$file")"
done

if [[ ${#generated_files[@]} -gt 5 ]]; then
    echo "  ... and $((success_count - 5)) more files"
fi

# Exit with error code if there were failures
if [[ $failed_count -gt 0 ]]; then
    exit 1
else
    exit 0
fi
