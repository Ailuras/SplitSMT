# SMT-LIB Format Conversion Scripts

This directory contains conversion scripts for transforming SMT-LIB files between different formats.

## 📋 Overview

The conversion workflow supports bidirectional transformations:

```
Original SMT-LIB ────────────────────────────────────-──┐
                                                        │
                  ┌───  convert_splitsmt2uf.py  ────┐   │
                  │                                 ▼   │
                  │                            UF Format│
                  │                                 │   │
                  └───  convert_uf2others.py ───────┤   │
                                                    │   │
                        ┌───────────────────────────┘   │
                        │                               │
                    ┌───▼─-──┐    ┌─────────┐    ┌──────▼──┐
                    │SplitSMT│    │ Generic │    │ Ostrich │
                    └────────┘    └─────────┘    └─────────┘
```

## 🔧 Scripts

### 1. `convert_splitsmt2uf.py`

Converts original SMT-LIB files to UF (Uninterpreted Functions) format.

**Features:**

- Inserts UF function declarations for string split operations
- Changes logic to `ALL`
- Removes `str.` prefix from function calls
- Removes `(exit)` statements
- **Preserves all comments**
- Independent execution (no external config files needed)

**Usage:**

```bash
# Single file
python3 convert_splitsmt2uf.py --input file.smt2 --output file_uf.smt2

# Directory
python3 convert_splitsmt2uf.py --input input_dir/ --output output_dir/

# Dry run
python3 convert_splitsmt2uf.py --input input_dir/ --dry-run
```

**Transformations:**

```smt2
# Input
(set-logic QF_SLIA)
(assert (= (str.split_at y "-" 2) x))

# Output
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(assert (= (split_at y "-" 2) x))
```

### 2. `convert_uf2others.py`

Converts UF format files to three different formats simultaneously.

**Features:**

- Generates three output formats from one input
- Supports both single file and batch directory conversion
- Independent processing for each format

**Usage:**

```bash
# Single file → 3 outputs
python3 convert_uf2others.py --input file_uf.smt2 --output output_dir/

# Directory → 3 subdirectories
python3 convert_uf2others.py --input uf_dir/ --output output_dir/

# Dry run
python3 convert_uf2others.py --input uf_dir/ --dry-run
```

**Output Formats:**

#### Format 1: `splitsmt/`

- **Purpose**: For SplitSMT solver
- **Changes**:
  - Removes UF declarations
  - Adds `str.` prefix back: `split_at` → `str.split_at`
  
```smt2
(set-logic ALL)
(assert (= (str.split_at y "-" 2) x))
```

#### Format 2: `generic/`

- **Purpose**: For cvc5, z3, z3-noodler
- **Changes**:
  - Keeps UF declarations as-is
  
```smt2
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(assert (= (split_at y "-" 2) x))
```

#### Format 3: `ostrich/`

- **Purpose**: For Ostrich solver
- **Changes**:
  - Keeps UF declarations
  - Adds special constant `-1`
  
```smt2
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const -1 Int)
(assert (= -1 (- 1)))
(assert (= (split_at y "-" 2) x))
```

## 🔄 Complete Workflow Example

### Step 1: Convert to UF format

```bash
python3 convert_splitsmt2uf.py \
  --input benchmarks/original/ \
  --output benchmarks/uf/
```

### Step 2: Generate all solver formats

```bash
python3 convert_uf2others.py \
  --input benchmarks/uf/ \
  --output benchmarks/converted/
```

### Result Structure

```
benchmarks/
├── original/           # Original SMT-LIB files
├── uf/                # UF format (intermediate)
└── converted/
    ├── splitsmt/      # For SplitSMT solver
    ├── generic/       # For cvc5, z3, z3-noodler
    └── ostrich/       # For Ostrich solver
```

## 📊 Supported Functions

The scripts handle the following string split functions:

| Function | Description |
|----------|-------------|
| `split_at` | Split string at delimiter, return part at index |
| `split_rest` | Split string at delimiter, return rest |
| `num_splits` | Count number of splits possible |

## ⚙️ Configuration Files

The `configs/` directory contains solver-specific UF declarations (for reference only - scripts don't depend on them):

```
configs/
├── UF/
│   ├── z3.txt
│   ├── cvc5.txt
│   ├── z3-noodler.txt
│   └── ostrich.txt
├── RA/
└── REC/
```

## 🎯 Use Cases

### Benchmark Preparation

Convert a collection of SMT-LIB benchmarks for testing different solvers:

```bash
# 1. Standardize to UF format
python3 convert_splitsmt2uf.py -i benchmarks/raw -o benchmarks/uf

# 2. Generate solver-specific versions
python3 convert_uf2others.py -i benchmarks/uf -o benchmarks/solvers
```

### Single File Testing

Quickly convert a single test case to all formats:

```bash
python3 convert_splitsmt2uf.py -i test.smt2 -o test_uf.smt2
python3 convert_uf2others.py -i test_uf.smt2 -o test_outputs/
```

## 📝 Notes

- All scripts preserve the original file structure when processing directories
- Comments are preserved by `convert_splitsmt2uf.py`
- Both scripts support `--dry-run` for preview without writing files
- Output files are automatically created with proper directory structure
- Scripts are standalone and don't require external dependencies beyond Python 3

## 🐛 Troubleshooting

**Issue**: Script doesn't recognize `.smt2` files

- **Solution**: Ensure files have the `.smt2` extension

**Issue**: Permission denied when writing files

- **Solution**: Check write permissions on the output directory

**Issue**: UF declarations not found/removed

- **Solution**: Verify input files are in the expected format (check first few lines)

## 📚 Related Tools

- `prepare.py`: Basic snippet insertion and string replacement
- `prepare_option.py`: Advanced preparation with model/nom versions
