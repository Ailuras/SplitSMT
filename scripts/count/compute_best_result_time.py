#!/usr/bin/env python3
"""
Compute best solver result and time per row for seeds_analysis.xlsx.

Rules:
- If any result in a row is 'UNCLEAR' (case-insensitive), leave both outputs empty.
- Otherwise, consider non-UNKNOWN results among the solver result columns;
  - If none exist -> best_result = 'UNKNOWN'.
  - If they disagree -> best_result = 'INCONSIST'.
  - If they all agree -> best_result = that value (e.g., 'SAT' or 'UNSAT').
- For best_time:
  - If best_result is neither 'UNKNOWN' nor 'INCONSIST', choose the minimum time
    across solvers that reported exactly best_result in that row. Ignore
    UNKNOWN or missing times.
  - Otherwise leave best_time empty.

Outputs are appended as two new columns: 'best_result' and 'best_time'.
The script updates scripts/count/seeds_analysis.xlsx in place by default.
"""

from __future__ import annotations

import argparse
from pathlib import Path
import math
from typing import List, Optional, Tuple

import pandas as pd


SOLVERS = [
    "ext-cvc5",
    "ext-ostrich",
    "ext-z3",
    "ext-z3-noodler",
]


def normalize(s: Optional[str]) -> Optional[str]:
    if s is None:
        return None
    if isinstance(s, float) and pd.isna(s):
        return None
    t = str(s).strip()
    return t if t != "" else None


def lower_or_none(s: Optional[str]) -> Optional[str]:
    s1 = normalize(s)
    return s1.lower() if s1 is not None else None


def compute_best_for_row(row: pd.Series, result_cols: List[str], time_cols: List[str]):
    # 1) UNCLEAR short-circuit
    results_norm = {col: lower_or_none(row.get(col)) for col in result_cols}
    if any(val == "unclear" for val in results_norm.values()):
        return "", None

    # 2) Determine best_result
    non_unknown = [
        v for v in results_norm.values() if v is not None and v != "unknown"
    ]
    if not non_unknown:
        best_result = "UNKNOWN"
    else:
        distinct = {v for v in non_unknown}
        if len(distinct) == 1:
            best_result = non_unknown[0].upper()
        else:
            best_result = "INCONSIST"

    # 3) Determine best_time
    if best_result in ("UNKNOWN", "INCONSIST", ""):
        return best_result, None

    # Only consider solvers that reported exactly best_result
    best_result_l = best_result.lower()
    times = []
    for r_col, t_col in zip(result_cols, time_cols):
        rv = results_norm.get(r_col)
        if rv == best_result_l:
            tv_raw = row.get(t_col)
            if tv_raw is None or (isinstance(tv_raw, float) and pd.isna(tv_raw)):
                continue
            try:
                tv = float(str(tv_raw).strip())
            except Exception:
                continue
            times.append(tv)

    if not times:
        return best_result, None
    return best_result, min(times)


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "--input",
        type=Path,
        default=Path("scripts/count/seeds_analysis.xlsx"),
        help="Path to the Excel file to update",
    )
    ap.add_argument(
        "--output",
        type=Path,
        default=None,
        help="Optional output path. If omitted, updates INPUT in place.",
    )
    args = ap.parse_args()

    path_in: Path = args.input
    path_out: Path = args.output if args.output is not None else path_in

    if not path_in.exists():
        raise SystemExit(f"Input file not found: {path_in}")

    with pd.ExcelFile(path_in) as xls:
        sheet_data_name = xls.sheet_names[0]
        df = pd.read_excel(xls, sheet_name=sheet_data_name)

    # Build column names
    result_cols = [f"{s}_result" for s in SOLVERS if f"{s}_result" in df.columns]
    time_cols = [f"{s}_time" for s in SOLVERS if f"{s}_time" in df.columns]

    # Align result/time columns in same order of SOLVERS intersection
    solver_order = [s for s in SOLVERS if f"{s}_result" in result_cols and f"{s}_time" in time_cols]
    result_cols = [f"{s}_result" for s in solver_order]
    time_cols = [f"{s}_time" for s in solver_order]

    if not result_cols:
        raise SystemExit("No solver result columns found.")

    best_results: List[str] = []
    best_times: List[Optional[float]] = []
    for _, row in df.iterrows():
        br, bt = compute_best_for_row(row, result_cols, time_cols)
        best_results.append(br)
        best_times.append(bt)

    df["best_result"] = best_results
    df["best_time"] = best_times

    # Save. Use openpyxl to preserve xlsx format.
    # Build stats per log based on best results
    df_stats_input = df.copy()
    best_result_norm = df_stats_input["best_result"].fillna("").str.strip().str.upper()
    df_stats_input["best_result_norm"] = best_result_norm.replace(
        {"INCONSIST": "UNKNOWN"}
    )
    df_stats_input["best_time_numeric"] = pd.to_numeric(
        df_stats_input["best_time"], errors="coerce"
    )

    # Filter rows with labeled results
    mask_labeled = df_stats_input["best_result_norm"].isin({"SAT", "UNSAT", "UNKNOWN"})
    df_labeled = df_stats_input[mask_labeled]

    # Counts per log
    counts_raw = (
        df_labeled.pivot_table(
            index="log",
            columns="best_result_norm",
            values="filename",
            aggfunc="count",
            fill_value=0,
        )
        .rename_axis(None, axis=1)
        .reset_index()
    )
    for col in ["SAT", "UNSAT", "UNKNOWN"]:
        if col not in counts_raw.columns:
            counts_raw[col] = 0
    counts_raw = counts_raw[["log", "SAT", "UNSAT", "UNKNOWN"]]
    counts_raw = counts_raw.rename(
        columns={
            "SAT": "sat_count",
            "UNSAT": "unsat_count",
            "UNKNOWN": "unknown_count",
        }
    )
    logs_all = df[["log"]].dropna().drop_duplicates()
    counts = logs_all.merge(counts_raw, on="log", how="left").fillna(0)
    counts[["sat_count", "unsat_count", "unknown_count"]] = (
        counts[["sat_count", "unsat_count", "unknown_count"]].astype(int)
    )

    # Success average time (sat or unsat)
    mask_success = df_stats_input["best_result_norm"].isin({"SAT", "UNSAT"})
    df_success = df_stats_input[mask_success & df_stats_input["best_time_numeric"].notna()]
    success_avg = (
        df_success.groupby("log")["best_time_numeric"].mean().reset_index(name="success_avg_time")
        if not df_success.empty
        else pd.DataFrame(columns=["log", "success_avg_time"])
    )

    stats = counts.merge(success_avg, on="log", how="left")

    # Scaled counts sum to 100, remainder goes to unknown
    def scale_counts(row: pd.Series) -> Tuple[int, int, int]:
        sat = int(row["sat_count"])
        unsat = int(row["unsat_count"])
        unknown = int(row["unknown_count"])
        total = sat + unsat + unknown
        if total == 0:
            return 0, 0, 0
        sat_scaled_f = sat / total * 100
        unsat_scaled_f = unsat / total * 100
        unknown_scaled_f = unknown / total * 100
        sat_scaled = int(math.floor(sat_scaled_f))
        unsat_scaled = int(math.floor(unsat_scaled_f))
        unknown_scaled = int(math.floor(unknown_scaled_f))
        remainder = 100 - (sat_scaled + unsat_scaled + unknown_scaled)
        unknown_scaled += remainder
        return sat_scaled, unsat_scaled, unknown_scaled

    scaled_values = stats.apply(scale_counts, axis=1, result_type="expand")
    scaled = stats[["log"]].copy()
    scaled["sat_scaled"] = scaled_values[0].astype(int)
    scaled["unsat_scaled"] = scaled_values[1].astype(int)
    scaled["unknown_scaled"] = scaled_values[2].astype(int)

    with pd.ExcelWriter(path_out, engine="openpyxl") as writer:
        df.to_excel(writer, index=False, sheet_name=sheet_data_name)
        stats.to_excel(writer, index=False, sheet_name="best_result_stats")
        scaled.to_excel(writer, index=False, sheet_name="best_result_distribution")
    print(f"Wrote: {path_out}")


if __name__ == "__main__":
    main()
