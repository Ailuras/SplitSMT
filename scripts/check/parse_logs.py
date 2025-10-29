#!/usr/bin/env python3
import argparse
import os
import sys
import re
import glob
import shutil
from pathlib import Path, PurePath
try:
    import openpyxl
    from openpyxl.styles import Font, Alignment, PatternFill
except ImportError:
    print("Error: openpyxl is required. Install it with: pip install openpyxl")
    sys.exit(1)

def parse_log_file(log_path):
    results = []
    with open(log_path, 'r', encoding='utf-8', errors='replace') as f:
        content = f.read()
    sections = content.split('===========================================================')
    for section in sections:
        section = section.strip()
        if not section:
            continue
        lines = section.split('\n')
        if len(lines) < 2:
            continue
        file_line = None
        start_time = None
        end_time = None
        duration = None
        status = None
        exit_code = None
        output_lines = []
        capture_output = False
        for i, line in enumerate(lines):
            line_stripped = line.strip()
            if line_stripped.startswith('FILE:'):
                file_line = line_stripped[5:].strip()
            elif line_stripped.startswith('START:'):
                start_time = line_stripped[6:].strip()
            elif line_stripped.startswith('END:'):
                end_time = line_stripped[4:].strip()
            elif line_stripped.startswith('DURATION_SEC:'):
                duration = line_stripped[13:].strip()
            elif line_stripped.startswith('STATUS:'):
                status = line_stripped[7:].strip()
            elif line_stripped.startswith('EXIT_CODE:'):
                exit_code = line_stripped[10:].strip()
            elif line_stripped.startswith('-----------------------------------------------------------'):
                capture_output = True
            elif capture_output:
                output_lines.append(line)
        if file_line:
            raw_output = '\n'.join(output_lines).strip()
            result_category = categorize_result(raw_output, status, exit_code)
            file_path = file_line
            category_type = extract_category_type(file_path)
            main_cat, sub_cat = extract_main_and_sub_category(file_path)
            results.append({
                'file_path': file_path,
                'category_type': category_type,
                'main_category': main_cat,
                'sub_category': sub_cat,
                'result': result_category,
                'duration_sec': duration,
                'start_time': start_time,
                'end_time': end_time,
                'status': status,
                'exit_code': exit_code,
                'raw_output': raw_output
            })
    return results

def categorize_result(output, status, exit_code):
    if not output:
        return 'Error'
    cleaned_output = remove_ansi_codes(output)
    lowered_output = cleaned_output.lower()
    lines = [line.strip() for line in lowered_output.split('\n') if line.strip()]
    if status == 'TIMEOUT':
        return 'Error'
    exit_code_value = None
    try:
        exit_code_value = int(exit_code) if exit_code is not None else None
    except (TypeError, ValueError):
        exit_code_value = None
    fatal_tokens = [
        'segmentation fault',
        'dumped core',
        'core dumped',
        'result: error',
        'timeout:',
        'killed',
        'floating point exception',
        'assertion failed',
        'stack trace'
    ]
    fatal_detected = any(token in lowered_output for token in fatal_tokens)
    if 'error:' in lowered_output or 'exception' in lowered_output:
        fatal_detected = True
    if exit_code_value in (124, 137, 143):
        fatal_detected = True
    if fatal_detected:
        return 'Error'
    has_sat = any(line == 'sat' for line in lines)
    has_unsat = any(line == 'unsat' for line in lines)
    has_unknown = any(line == 'unknown' for line in lines)
    if has_sat and has_unsat:
        return 'Error'
    if has_unsat:
        return 'UNSAT'
    if has_sat:
        return 'SAT'
    if has_unknown:
        others = [line for line in lines if line != 'unknown']
        if others:
            return 'Error'
        return 'Unknown'
    return 'Error'

def remove_ansi_codes(text):
    ansi_escape = re.compile(r'\x1b\[[0-9;]*m')
    return ansi_escape.sub('', text)

def extract_category_type(file_path):
    parts = file_path.split('/')
    if len(parts) > 1:
        return '/'.join(parts[:-1])
    return ''

def extract_main_and_sub_category(file_path):
    parts = file_path.split('/')
    if len(parts) <= 1:
        return ('', '')
    path_parts = parts[:-1]
    if path_parts and path_parts[0] == 'benchmarks':
        path_parts = path_parts[1:]
    if len(path_parts) == 0:
        return ('', '')
    elif len(path_parts) == 1:
        return (path_parts[0], '')
    else:
        main_category = path_parts[0]
        sub_category = '/'.join(path_parts[1:])
        return (main_category, sub_category)


def normalize_relative_path(path_str, fallback_name):
    pure_path = PurePath(path_str)
    components = []
    for part in pure_path.parts:
        if part in ('', '.', os.path.sep, '/', '\\'):
            continue
        if len(part) == 2 and part[1] == ':' and part[0].isalpha():
            # Skip drive letters like C:
            continue
        if part == '..':
            if components:
                components.pop()
            continue
        components.append(part)
    if not components:
        return Path(fallback_name)
    return Path(*components)


def resolve_source_file(file_path_str, candidate_roots):
    expanded = os.path.expanduser(file_path_str.strip())
    path_candidate = Path(expanded)
    if path_candidate.is_absolute() and path_candidate.exists():
        return path_candidate.resolve(), None
    resolved_roots = [root.resolve() for root in candidate_roots]
    for root in resolved_roots:
        candidate = (root / path_candidate).resolve()
        if candidate.exists():
            return candidate, root
    fallback = (Path.cwd() / path_candidate).resolve()
    if fallback.exists():
        return fallback, Path.cwd().resolve()
    return None, None


def save_error_files(all_results, dest_dir, candidate_roots, relative_bases):
    dest_path = Path(dest_dir).resolve()
    dest_path.mkdir(parents=True, exist_ok=True)
    copied_targets = set()
    missing_files = []
    copied_count = 0
    resolved_bases = []
    for base in relative_bases:
        base_path = base.resolve()
        if base_path not in resolved_bases:
            resolved_bases.append(base_path)
    for result in all_results:
        if result['result'] != 'Error':
            continue
        source_path, matched_root = resolve_source_file(result['file_path'], candidate_roots)
        if not source_path:
            missing_files.append(result['file_path'])
            continue
        relative_path = None
        for base in resolved_bases:
            try:
                relative_path = source_path.relative_to(base)
                break
            except ValueError:
                continue
        if relative_path is None and matched_root is not None:
            try:
                relative_path = source_path.relative_to(matched_root.resolve())
            except ValueError:
                relative_path = None
        if relative_path is None:
            relative_path = normalize_relative_path(result['file_path'], source_path.name)
        target_path = dest_path / relative_path
        if target_path in copied_targets:
            continue
        target_path.parent.mkdir(parents=True, exist_ok=True)
        shutil.copy2(source_path, target_path)
        copied_targets.add(target_path)
        copied_count += 1
    print(f"Saved {copied_count} error file(s) under {dest_path}")
    if missing_files:
        print("Warning: unable to locate the following error inputs:")
        for missing in missing_files:
            print(f"  {missing}")

def write_to_excel(all_results, output_path):
    wb = openpyxl.Workbook()
    ws = wb.active
    ws.title = "Results"
    headers = ['File Path', 'Main Category', 'Sub Category', 'Result', 'Duration (sec)', 'Start Time', 'End Time', 'Status', 'Exit Code', 'Raw Output']
    ws.append(headers)
    header_fill = PatternFill(start_color='4F81BD', end_color='4F81BD', fill_type='solid')
    header_font = Font(bold=True, color='FFFFFF')
    for cell in ws[1]:
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = Alignment(horizontal='center', vertical='center')
    result_colors = {
        'SAT': 'C6EFCE',
        'UNSAT': 'FFC7CE',
        'Unknown': 'FFEB9C',
        'Error': 'FF9999'
    }
    for result in all_results:
        row = [
            result['file_path'],
            result['main_category'],
            result['sub_category'],
            result['result'],
            result['duration_sec'],
            result['start_time'],
            result['end_time'],
            result['status'],
            result['exit_code'],
            remove_ansi_codes(result['raw_output'])
        ]
        ws.append(row)
        row_num = ws.max_row
        result_type = result['result']
        if result_type in result_colors:
            fill = PatternFill(start_color=result_colors[result_type], end_color=result_colors[result_type], fill_type='solid')
            ws.cell(row=row_num, column=4).fill = fill
    ws.column_dimensions['A'].width = 60
    ws.column_dimensions['B'].width = 20
    ws.column_dimensions['C'].width = 35
    ws.column_dimensions['D'].width = 12
    ws.column_dimensions['E'].width = 15
    ws.column_dimensions['F'].width = 20
    ws.column_dimensions['G'].width = 20
    ws.column_dimensions['H'].width = 12
    ws.column_dimensions['I'].width = 12
    ws.column_dimensions['J'].width = 80
    for row in ws.iter_rows(min_row=2, max_row=ws.max_row):
        for cell in row:
            cell.alignment = Alignment(vertical='top', wrap_text=True)
    summary_ws = wb.create_sheet(title="Summary")
    summary_ws.append(['Result Type', 'Count', 'Percentage'])
    summary_ws[1][0].fill = header_fill
    summary_ws[1][1].fill = header_fill
    summary_ws[1][2].fill = header_fill
    summary_ws[1][0].font = header_font
    summary_ws[1][1].font = header_font
    summary_ws[1][2].font = header_font
    total_count = len(all_results)
    result_counts = {'SAT': 0, 'UNSAT': 0, 'Unknown': 0, 'Error': 0}
    for result in all_results:
        result_counts[result['result']] += 1
    for result_type in ['SAT', 'UNSAT', 'Unknown', 'Error']:
        count = result_counts[result_type]
        percentage = (count / total_count * 100) if total_count > 0 else 0
        summary_ws.append([result_type, count, f'{percentage:.2f}%'])
        row_num = summary_ws.max_row
        if result_type in result_colors:
            fill = PatternFill(start_color=result_colors[result_type], end_color=result_colors[result_type], fill_type='solid')
            summary_ws.cell(row=row_num, column=1).fill = fill
    summary_ws.append(['Total', total_count, '100.00%'])
    summary_ws.column_dimensions['A'].width = 15
    summary_ws.column_dimensions['B'].width = 10
    summary_ws.column_dimensions['C'].width = 12
    category_ws = wb.create_sheet(title="By Category")
    category_ws.append(['Main Category', 'Sub Category', 'SAT', 'UNSAT', 'Unknown', 'Error', 'Total'])
    for cell in category_ws[1]:
        cell.fill = header_fill
        cell.font = header_font
        cell.alignment = Alignment(horizontal='center', vertical='center')
    category_stats = {}
    for result in all_results:
        main_cat = result['main_category']
        sub_cat = result['sub_category']
        cat_key = (main_cat, sub_cat)
        if cat_key not in category_stats:
            category_stats[cat_key] = {'SAT': 0, 'UNSAT': 0, 'Unknown': 0, 'Error': 0}
        category_stats[cat_key][result['result']] += 1
    for cat_key in sorted(category_stats.keys()):
        main_cat, sub_cat = cat_key
        stats = category_stats[cat_key]
        total = sum(stats.values())
        category_ws.append([main_cat, sub_cat, stats['SAT'], stats['UNSAT'], stats['Unknown'], stats['Error'], total])
    category_ws.column_dimensions['A'].width = 20
    category_ws.column_dimensions['B'].width = 35
    for col in ['C', 'D', 'E', 'F', 'G']:
        category_ws.column_dimensions[col].width = 12
    wb.save(output_path)
    print(f"Excel file saved to: {output_path}")

def parse_arguments():
    parser = argparse.ArgumentParser(
        description="Parse SplitSMT batch logs and compile results into an Excel workbook."
    )
    parser.add_argument(
        "log_directory",
        help="Directory containing log files (e.g., results/awesome_logs)",
    )
    parser.add_argument(
        "output_excel",
        nargs="?",
        help="Optional path to the generated Excel file (default: <log_directory>/../analysis.xlsx)",
    )
    parser.add_argument(
        "--save-errors-dir",
        dest="save_errors_dir",
        help="If set, copy all error-case SMT2 inputs into this directory while preserving structure.",
    )
    parser.add_argument(
        "--source-root",
        dest="source_root",
        help="Override the root directory used to resolve relative SMT2 paths (default: repository root).",
    )
    return parser.parse_args()


def main():
    args = parse_arguments()
    log_dir = args.log_directory
    if args.output_excel:
        output_excel = args.output_excel
    else:
        normalized_log_dir = log_dir.rstrip(os.sep)
        parent_dir = os.path.dirname(normalized_log_dir) if os.path.dirname(normalized_log_dir) else '.'
        output_excel = os.path.join(parent_dir, 'analysis.xlsx')

    if not os.path.isdir(log_dir):
        print(f"Error: Directory not found: {log_dir}")
        sys.exit(1)

    log_files = sorted(glob.glob(os.path.join(log_dir, '*.log')))
    if not log_files:
        print(f"No log files found in {log_dir}")
        sys.exit(1)

    print(f"Found {len(log_files)} log files in {log_dir}")
    all_results = []
    for log_file in log_files:
        print(f"Processing {os.path.basename(log_file)}...")
        results = parse_log_file(log_file)
        all_results.extend(results)

    print(f"\nTotal entries parsed: {len(all_results)}")
    result_counts = {'SAT': 0, 'UNSAT': 0, 'Unknown': 0, 'Error': 0}
    for result in all_results:
        result_counts[result['result']] += 1

    print("\nResult Summary:")
    total_entries = len(all_results)
    for result_type in ['SAT', 'UNSAT', 'Unknown', 'Error']:
        count = result_counts[result_type]
        percentage = (count / total_entries * 100) if total_entries > 0 else 0
        print(f"  {result_type}: {count} ({percentage:.2f}%)")

    write_to_excel(all_results, output_excel)

    if args.save_errors_dir:
        repo_root = Path(__file__).resolve().parents[2]
        candidate_roots = []

        def add_candidate(root):
            if root is None:
                return
            resolved_root = root.resolve()
            if resolved_root not in candidate_roots:
                candidate_roots.append(resolved_root)

        if args.source_root:
            add_candidate(Path(args.source_root))
        add_candidate(Path.cwd())
        add_candidate(repo_root)

        relative_bases = []
        if args.source_root:
            relative_bases.append(Path(args.source_root))
        relative_bases.append(repo_root)

        save_error_files(all_results, args.save_errors_dir, candidate_roots, relative_bases)

    print("\nDone!")

if __name__ == '__main__':
    main()
