#!/usr/bin/env python3
from __future__ import annotations

import argparse
from pathlib import Path
from typing import Dict, List

from openpyxl import load_workbook


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Fill table.tex from summary.xlsx")
    parser.add_argument("--summary", type=Path, default=Path("results/summary.xlsx"))
    parser.add_argument("--table", type=Path, default=Path("scripts/experiment/template.tex"))
    parser.add_argument("--output", type=Path, default=Path("scripts/experiment/tables.tex"))
    return parser.parse_args()


def read_solver_sheet(path: Path, sheet: str) -> List[Dict[str, object]]:
    wb = load_workbook(path, data_only=True)
    ws = wb[sheet]
    headers = [c.value for c in ws[1]]
    header_map = {str(h).strip(): idx for idx, h in enumerate(headers) if h is not None}
    rows = []
    for row in ws.iter_rows(min_row=2, values_only=True):
        if row is None or all(v is None for v in row):
            continue
        record = {}
        for key, idx in header_map.items():
            record[key] = row[idx] if idx < len(row) else None
        rows.append(record)
    return rows


def normalize_result(value) -> str:
    if value is None:
        return ""
    return str(value).strip().upper()


def is_number(value) -> bool:
    return isinstance(value, (int, float))


def avg_time(time_sum: float, time_count: int) -> float:
    if time_count == 0:
        return 0.0
    return time_sum / time_count


def fmt_int(value: int) -> str:
    return str(int(value))


def fmt_time(value: float) -> str:
    return f"{value:.2f}"


def build_model_stats(rows, category_picker):
    stats = {}
    model_fields = {
        "Ours": "splitsmt",
        "RALen": "RA",
        "RecLen": "REC",
        "UF-split": "UF",
    }
    for row in rows:
        category = category_picker(row)
        if not category:
            continue
        if category not in stats:
            stats[category] = {
                "count": 0,
                "models": {m: {"sat": 0, "unsat": 0, "time_sum": 0.0, "time_count": 0} for m in model_fields},
            }
        entry = stats[category]
        entry["count"] += 1
        for label, prefix in model_fields.items():
            result = normalize_result(row.get(f"{prefix}_result"))
            if result == "SAT":
                entry["models"][label]["sat"] += 1
            elif result == "UNSAT":
                entry["models"][label]["unsat"] += 1
            time_val = row.get(f"{prefix}_time")
            if is_number(time_val) and result in ("SAT", "UNSAT"):
                entry["models"][label]["time_sum"] += float(time_val)
                entry["models"][label]["time_count"] += 1
    return stats


def build_solver_stats(rows, category_picker):
    stats = {}
    for row in rows:
        category = category_picker(row)
        if not category:
            continue
        if category not in stats:
            stats[category] = {"count": 0, "sat": 0, "unsat": 0, "unk": 0, "time_sum": 0.0, "time_count": 0}
        entry = stats[category]
        entry["count"] += 1
        result = normalize_result(row.get("splitsmt_result"))
        if result == "SAT":
            entry["sat"] += 1
        elif result == "UNSAT":
            entry["unsat"] += 1
        else:
            entry["unk"] += 1
        time_val = row.get("splitsmt_time")
        if is_number(time_val) and result in ("SAT", "UNSAT"):
            entry["time_sum"] += float(time_val)
            entry["time_count"] += 1
    return stats


def totals_from_model_stats(stats, categories):
    total = {
        "count": 0,
        "models": {m: {"sat": 0, "unsat": 0, "time_sum": 0.0, "time_count": 0} for m in ["Ours", "RALen", "RecLen", "UF-split"]},
    }
    for category in categories:
        entry = stats.get(category)
        if not entry:
            continue
        total["count"] += entry["count"]
        for model, model_stat in entry["models"].items():
            total["models"][model]["sat"] += model_stat["sat"]
            total["models"][model]["unsat"] += model_stat["unsat"]
            total["models"][model]["time_sum"] += model_stat["time_sum"]
            total["models"][model]["time_count"] += model_stat["time_count"]
    return total


def totals_from_solver_stats(stats, categories):
    total = {"count": 0, "sat": 0, "unsat": 0, "unk": 0, "time_sum": 0.0, "time_count": 0}
    for category in categories:
        entry = stats.get(category)
        if not entry:
            continue
        total["count"] += entry["count"]
        total["sat"] += entry["sat"]
        total["unsat"] += entry["unsat"]
        total["unk"] += entry["unk"]
        total["time_sum"] += entry["time_sum"]
        total["time_count"] += entry["time_count"]
    return total



def build_unique_stats(rows, category_picker):
    stats = {}
    model_fields = {
        "Ours": "splitsmt",
        "RALen": "RA",
        "RecLen": "REC",
        "UF-split": "UF",
    }
    for row in rows:
        category = category_picker(row)
        if not category:
            continue
        if category not in stats:
            stats[category] = {
                "count": 0,
                "models": {m: {"sat": 0, "unsat": 0} for m in model_fields},
            }
        entry = stats[category]
        entry["count"] += 1

        solved_by = []
        for label, prefix in model_fields.items():
            result = normalize_result(row.get(f"{prefix}_result"))
            if result in ("SAT", "UNSAT"):
                solved_by.append((label, result))

        if len(solved_by) == 1:
            winner_name, result = solved_by[0]
            if result == "SAT":
                entry["models"][winner_name]["sat"] += 1
            elif result == "UNSAT":
                entry["models"][winner_name]["unsat"] += 1
    return stats


def totals_from_unique_stats(stats, categories):
    total = {
        "count": 0,
        "models": {m: {"sat": 0, "unsat": 0} for m in ["Ours", "RALen", "RecLen", "UF-split"]},
    }
    for category in categories:
        entry = stats.get(category)
        if not entry:
            continue
        total["count"] += entry["count"]
        for model, model_stat in entry["models"].items():
            total["models"][model]["sat"] += model_stat["sat"]
            total["models"][model]["unsat"] += model_stat["unsat"]
    return total


def fill_row_placeholders(line: str, values: List[str]) -> str:
    output = line
    for value in values:
        output = output.replace("\\EXPtodo{--}", value, 1)
    return output


def main() -> int:
    args = parse_args()
    rows_default = read_solver_sheet(args.summary, "z3-noodler")
    rows_z3 = read_solver_sheet(args.summary, "z3")
    rows_cvc5 = read_solver_sheet(args.summary, "cvc5")
    rows_ostrich = read_solver_sheet(args.summary, "ostrich")
    rows_z3n = rows_default

    realworld_map = {
        "top20_maven": "Maven",
        "top20_gh": "GitHub",
        "awesome": "Awesome",
        "seqstr": "SeqStr",
    }
    synthetic_map = {
        "easy": "Simple",
        "complex": "Complex",
        "scenarios": "Scenarios",
    }

    def pick_realworld(row):
        suite = str(row.get("suite", "")).strip()
        category = str(row.get("category", "")).strip()
        if suite != "RealWorld":
            return ""
        return realworld_map.get(category, "")

    def pick_synthetic(row):
        suite = str(row.get("suite", "")).strip()
        category = str(row.get("category", "")).strip()
        if suite == "RealWorld":
            return ""
        return synthetic_map.get(category, "")

    def pick_per_solver(row):
        suite = str(row.get("suite", "")).strip()
        category = str(row.get("category", "")).strip()
        if suite == "RealWorld":
            return "RealWorld"
        return synthetic_map.get(category, "")

    realworld_categories = ["Maven", "GitHub", "Awesome", "SeqStr"]
    synthetic_categories = ["Simple", "Complex", "Scenarios"]
    solver_categories = ["Simple", "Complex", "Scenarios", "RealWorld"]

    realworld_stats = build_model_stats(rows_default, pick_realworld)
    synthetic_stats = build_model_stats(rows_default, pick_synthetic)
    realworld_total = totals_from_model_stats(realworld_stats, realworld_categories)
    synthetic_total = totals_from_model_stats(synthetic_stats, synthetic_categories)

    solver_stats = {
        "Z3": build_solver_stats(rows_z3, pick_per_solver),
        "CVC5": build_solver_stats(rows_cvc5, pick_per_solver),
        "Ostrich": build_solver_stats(rows_ostrich, pick_per_solver),
        "Z3-Noodler": build_solver_stats(rows_z3n, pick_per_solver),
    }
    solver_totals = {name: totals_from_solver_stats(stats, solver_categories) for name, stats in solver_stats.items()}

    realworld_unique_stats = build_unique_stats(rows_default, pick_realworld)
    synthetic_unique_stats = build_unique_stats(rows_default, pick_synthetic)
    realworld_unique_total = totals_from_unique_stats(realworld_unique_stats, realworld_categories)
    synthetic_unique_total = totals_from_unique_stats(synthetic_unique_stats, synthetic_categories)
    
    # Grand total for unique stats (RealWorld + Synthetic)
    total_unique_total = {
        "count": realworld_unique_total["count"] + synthetic_unique_total["count"],
        "models": {
            m: {
                "sat": realworld_unique_total["models"][m]["sat"] + synthetic_unique_total["models"][m]["sat"],
                "unsat": realworld_unique_total["models"][m]["unsat"] + synthetic_unique_total["models"][m]["unsat"],
            }
            for m in ["Ours", "RALen", "RecLen", "UF-split"]
        }
    }

    content = args.table.read_text(encoding="utf-8")
    lines = content.splitlines()
    out_lines = []
    table_mode = ""
    for line in lines:
        if "Real-world benchmarks" in line or "tab:realworld-ours-vs-baselines" in line:
            table_mode = "realworld"
        elif "Synthetic benchmarks" in line or "tab:synthetic-ours-vs-baselines" in line:
            table_mode = "synthetic"
        elif "tab:type-merged" in line:
            table_mode = "per-solver"
        elif "tab:unique-solved-counts" in line:
            table_mode = "unique"
        elif "\\end{table" in line: # table or table*
            table_mode = ""

        if table_mode == "realworld":
            for category in realworld_categories:
                if line.strip().startswith(category):
                    entry = realworld_stats.get(category, {"count": 0, "models": {}})
                    values = [fmt_int(entry["count"])]
                    for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                        model_stat = entry["models"].get(model, {"sat": 0, "unsat": 0, "time_sum": 0.0, "time_count": 0})
                        values.extend(
                            [
                                fmt_int(model_stat["sat"]),
                                fmt_int(model_stat["unsat"]),
                                fmt_time(avg_time(model_stat["time_sum"], model_stat["time_count"])),
                            ]
                        )
                    line = fill_row_placeholders(line, values)
            if "Total" in line:
                entry = realworld_total
                values = [fmt_int(entry["count"])]
                for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                    model_stat = entry["models"][model]
                    values.extend(
                        [
                            fmt_int(model_stat["sat"]),
                            fmt_int(model_stat["unsat"]),
                            fmt_time(avg_time(model_stat["time_sum"], model_stat["time_count"])),
                        ]
                    )
                line = fill_row_placeholders(line, values)

        if table_mode == "synthetic":
            for category in synthetic_categories:
                if line.strip().startswith(category):
                    entry = synthetic_stats.get(category, {"count": 0, "models": {}})
                    values = [fmt_int(entry["count"])]
                    for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                        model_stat = entry["models"].get(model, {"sat": 0, "unsat": 0, "time_sum": 0.0, "time_count": 0})
                        values.extend(
                            [
                                fmt_int(model_stat["sat"]),
                                fmt_int(model_stat["unsat"]),
                                fmt_time(avg_time(model_stat["time_sum"], model_stat["time_count"])),
                            ]
                        )
                    line = fill_row_placeholders(line, values)
            if "Total" in line:
                entry = synthetic_total
                values = [fmt_int(entry["count"])]
                for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                    model_stat = entry["models"][model]
                    values.extend(
                        [
                            fmt_int(model_stat["sat"]),
                            fmt_int(model_stat["unsat"]),
                            fmt_time(avg_time(model_stat["time_sum"], model_stat["time_count"])),
                        ]
                    )
                line = fill_row_placeholders(line, values)

        if table_mode == "per-solver":
            for category in solver_categories:
                if line.strip().startswith(category):
                    values = []
                    sample = solver_stats["Z3"].get(category, {"count": 0})
                    values.append(fmt_int(sample.get("count", 0)))
                    for solver_name in ["Z3", "CVC5", "Ostrich", "Z3-Noodler"]:
                        entry = solver_stats[solver_name].get(
                            category,
                            {"sat": 0, "unsat": 0, "unk": 0, "time_sum": 0.0, "time_count": 0},
                        )
                        values.extend(
                            [
                                fmt_int(entry["sat"]),
                                fmt_int(entry["unsat"]),
                                fmt_time(avg_time(entry["time_sum"], entry["time_count"])),
                            ]
                        )
                    line = fill_row_placeholders(line, values)
            if "Total" in line:
                values = []
                sample = solver_totals["Z3"]
                values.append(fmt_int(sample.get("count", 0)))
                for solver_name in ["Z3", "CVC5", "Ostrich", "Z3-Noodler"]:
                    entry = solver_totals[solver_name]
                    values.extend(
                        [
                            fmt_int(entry["sat"]),
                            fmt_int(entry["unsat"]),
                            fmt_time(avg_time(entry["time_sum"], entry["time_count"])),
                        ]
                    )
                line = fill_row_placeholders(line, values)
                line = fill_row_placeholders(line, values)

        if table_mode == "unique":
            # Real-World Section
            for category in realworld_categories:
                if line.strip().startswith(category):
                    entry = realworld_unique_stats.get(category, {"count": 0, "models": {}})
                    values = []
                    for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                        model_stat = entry["models"].get(model, {"sat": 0, "unsat": 0})
                        values.extend([fmt_int(model_stat["sat"]), fmt_int(model_stat["unsat"])])
                    line = fill_row_placeholders(line, values)
            
            # Synthetic Section
            for category in synthetic_categories:
                if line.strip().startswith(category):
                    entry = synthetic_unique_stats.get(category, {"count": 0, "models": {}})
                    values = []
                    for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                        model_stat = entry["models"].get(model, {"sat": 0, "unsat": 0})
                        values.extend([fmt_int(model_stat["sat"]), fmt_int(model_stat["unsat"])])
                    line = fill_row_placeholders(line, values)

            # Total Row
            if "\\textbf{Total}" in line:
                entry = total_unique_total
                values = []
                for model in ["Ours", "RALen", "RecLen", "UF-split"]:
                    model_stat = entry["models"][model]
                    values.extend([fmt_int(model_stat["sat"]), fmt_int(model_stat["unsat"])])
                line = fill_row_placeholders(line, values)

        out_lines.append(line)

    args.output.write_text("\n".join(out_lines) + "\n", encoding="utf-8")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
