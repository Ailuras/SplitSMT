#!/usr/bin/env python3
from __future__ import annotations

import argparse
import pathlib
import re
import subprocess
import sys
import tempfile
from concurrent.futures import ProcessPoolExecutor, as_completed
from typing import List, Tuple, Union

STATUS_PATTERN = re.compile(r"\b(sat|unsat|unknown)\b", re.IGNORECASE)
REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
SOLVER_ORDER = ["z3", "ostrich", "cvc5", "z3-noodler"]


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Check UF model against RA constraints.",
    )
    parser.add_argument("uf_file", type=pathlib.Path)
    parser.add_argument("ra_file", type=pathlib.Path)
    parser.add_argument("save_dir", type=pathlib.Path)
    parser.add_argument("--timeout", type=int, default=10, help="Timeout for each solver invocation")
    parser.add_argument("--all-arity", action="store_true", default=False)
    parser.add_argument("-j", "--jobs", type=int, default=1, help="Number of parallel jobs")
    return parser.parse_args()


def detect_status(stdout: str, stderr: str, exit_code: int) -> str:
    if exit_code in {124, 137, 143}:
        return "timeout"
    for stream in (stdout, stderr):
        for line in stream.splitlines():
            if line.strip().lower() in ("sat", "unsat", "unknown"):
                return line.strip().lower()
            match = STATUS_PATTERN.search(line)
            if match:
                return match.group(1).lower()
    return "ok" if exit_code == 0 else "error"


def run_solver(smt_file: pathlib.Path, timeout: int, solver: str) -> Tuple[str, str, str, int]:
    script_path = REPO_ROOT / "solvers" / f"{solver}.sh"
    completed = subprocess.run(
        [str(script_path), str(timeout), str(smt_file)],
        cwd=str(REPO_ROOT),
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
    )
    stdout = completed.stdout or ""
    stderr = completed.stderr or ""
    status = detect_status(stdout, stderr, completed.returncode)
    return status, stdout, stderr, completed.returncode


def insert_get_model(content: str) -> str:
    if "(get-model)" in content:
        return content
    exit_match = re.search(r"\(exit\)", content)
    if exit_match:
        idx = exit_match.start()
        return content[:idx] + "(get-model)\n" + content[idx:]
    if content and not content.endswith("\n"):
        content += "\n"
    return content + "(get-model)\n"


def extract_model_block(stdout: str) -> str:
    idx = stdout.find("(model")
    if idx == -1:
        return ""
    depth = 0
    end = None
    for i in range(idx, len(stdout)):
        c = stdout[i]
        if c == "(":
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0:
                end = i + 1
                break
    if end is None:
        return ""
    return stdout[idx:end]


Token = str
SExpr = Union[Token, List["SExpr"]]


def tokenize(text: str) -> List[Token]:
    tokens: List[Token] = []
    i = 0
    while i < len(text):
        c = text[i]
        if c.isspace():
            i += 1
            continue
        if c in ("(", ")"):
            tokens.append(c)
            i += 1
            continue
        if c == '"':
            j = i + 1
            buf = ['"']
            escape = False
            while j < len(text):
                ch = text[j]
                buf.append(ch)
                if escape:
                    escape = False
                elif ch == "\\":
                    escape = True
                elif ch == '"':
                    j += 1
                    break
                j += 1
            tokens.append("".join(buf))
            i = j
            continue
        j = i
        while j < len(text) and not text[j].isspace() and text[j] not in ("(", ")"):
            j += 1
        tokens.append(text[i:j])
        i = j
    return tokens


def parse_expr(tokens: List[Token], idx: int) -> Tuple[SExpr, int]:
    tok = tokens[idx]
    if tok == "(":
        idx += 1
        items: List[SExpr] = []
        while idx < len(tokens) and tokens[idx] != ")":
            item, idx = parse_expr(tokens, idx)
            items.append(item)
        return items, idx + 1
    return tok, idx + 1


def parse_sexpr(text: str) -> SExpr:
    tokens = tokenize(text)
    if not tokens:
        return []
    expr, _ = parse_expr(tokens, 0)
    return expr


def sexpr_to_string(expr: SExpr) -> str:
    if isinstance(expr, list):
        return "(" + " ".join(sexpr_to_string(e) for e in expr) + ")"
    return expr


def parse_all_sexprs(text: str) -> List[SExpr]:
    tokens = tokenize(text)
    exprs: List[SExpr] = []
    idx = 0
    while idx < len(tokens):
        expr, idx = parse_expr(tokens, idx)
        exprs.append(expr)
    return exprs


def extract_model_defs(stdout: str) -> Tuple[List[SExpr], str]:
    model_block = extract_model_block(stdout)
    if model_block:
        expr = parse_sexpr(model_block)
        if isinstance(expr, list) and expr and expr[0] == "model":
            defs = [e for e in expr[1:] if isinstance(e, list)]
            return defs, model_block
    cleaned = stdout.strip()
    if cleaned.lower().startswith("sat"):
        cleaned = cleaned.split("\n", 1)[1] if "\n" in cleaned else ""
    exprs = parse_all_sexprs(cleaned)
    if len(exprs) == 1 and isinstance(exprs[0], list):
        defs = [e for e in exprs[0] if isinstance(e, list)]
        if defs:
            return defs, cleaned
    defs = [e for e in exprs if isinstance(e, list)]
    return defs, cleaned if defs else ""


def model_to_def_map(defs: List[SExpr]) -> dict[str, Tuple[str, str]]:
    result: dict[str, Tuple[str, str]] = {}
    for item in defs:
        if not isinstance(item, list) or not item:
            continue
        head = item[0]
        if head == "define-fun" and len(item) >= 5:
            params = item[2]
            if isinstance(params, list) and len(params) == 0:
                name = sexpr_to_string(item[1])
                sort = sexpr_to_string(item[3])
                value = sexpr_to_string(item[4])
                result[name] = (sort, value)
        elif head == "define-const" and len(item) >= 4:
            name = sexpr_to_string(item[1])
            sort = sexpr_to_string(item[2])
            value = sexpr_to_string(item[3])
            result[name] = (sort, value)
    return result


def model_defs_to_asserts(defs: List[SExpr], excluded: set[str]) -> List[str]:
    asserts: List[str] = []
    for item in defs:
        if not isinstance(item, list) or not item:
            continue
        head = item[0]
        if head == "define-fun" and len(item) >= 5:
            name = sexpr_to_string(item[1])
            if name in excluded:
                continue
            params = item[2]
            value = sexpr_to_string(item[4])
            if isinstance(params, list) and len(params) == 0:
                asserts.append(f"(assert (= {name} {value}))")
            elif isinstance(params, list):
                param_strs = []
                arg_names = []
                valid = True
                for param in params:
                    if not isinstance(param, list) or len(param) < 2:
                        valid = False
                        break
                    param_strs.append(sexpr_to_string(param))
                    arg_names.append(sexpr_to_string(param[0]))
                if valid:
                    args = " ".join(arg_names)
                    param_list = " ".join(param_strs)
                    asserts.append(f"(assert (forall ({param_list}) (= ({name} {args}) {value})))")
        elif head == "define-const" and len(item) >= 4:
            name = sexpr_to_string(item[1])
            if name in excluded:
                continue
            value = sexpr_to_string(item[3])
            asserts.append(f"(assert (= {name} {value}))")
    return asserts


def split_top_level_spans(text: str) -> List[Tuple[int, int, str]]:
    spans: List[Tuple[int, int, str]] = []
    depth = 0
    start = None
    in_str = False
    escape = False
    i = 0
    while i < len(text):
        c = text[i]
        if in_str:
            if escape:
                escape = False
            elif c == "\\":
                escape = True
            elif c == '"':
                in_str = False
            i += 1
            continue
        if c == '"':
            in_str = True
            i += 1
            continue
        if c == ";":
            j = text.find("\n", i)
            if j == -1:
                break
            i = j + 1
            continue
        if c == "(":
            if depth == 0:
                start = i
            depth += 1
        elif c == ")":
            depth -= 1
            if depth == 0 and start is not None:
                spans.append((start, i + 1, text[start:i + 1]))
                start = None
        i += 1
    return spans


def normalize_ra_and_symbols(content: str) -> Tuple[str, set[str]]:
    spans = split_top_level_spans(content)
    if not spans:
        return content, set()
    pieces: List[str] = []
    last = 0
    symbols: set[str] = set()
    defined: set[str] = set()
    for start, end, expr_text in spans:
        pieces.append(content[last:start])
        expr = parse_sexpr(expr_text)
        kept = True
        if isinstance(expr, list) and expr:
            head = expr[0]
            if head in {"declare-fun", "declare-const"}:
                name = sexpr_to_string(expr[1]) if len(expr) > 1 else ""
                if name:
                    symbols.add(name)
                    if name in defined:
                        kept = False
            elif head in {"define-fun", "define-const"}:
                name = sexpr_to_string(expr[1]) if len(expr) > 1 else ""
                if name:
                    symbols.add(name)
                    defined.add(name)
        if kept:
            pieces.append(expr_text)
        last = end
    pieces.append(content[last:])
    return "".join(pieces), symbols


def model_defs_to_asserts_filtered(defs: List[SExpr], excluded: set[str], allowed: set[str], only_zero_arity: bool) -> List[str]:
    asserts: List[str] = []
    for item in defs:
        if not isinstance(item, list) or not item:
            continue
        head = item[0]
        if head == "define-fun" and len(item) >= 5:
            name = sexpr_to_string(item[1])
            if name in excluded or (allowed and name not in allowed):
                continue
            params = item[2]
            value = sexpr_to_string(item[4])
            if contains_unknown_symbol(value, allowed):
                continue
            if isinstance(params, list) and len(params) == 0:
                asserts.append(f"(assert (= {name} {value}))")
            elif isinstance(params, list) and not only_zero_arity:
                param_strs = []
                arg_names = []
                valid = True
                for param in params:
                    if not isinstance(param, list) or len(param) < 2:
                        valid = False
                        break
                    param_strs.append(sexpr_to_string(param))
                    arg_names.append(sexpr_to_string(param[0]))
                if valid:
                    args = " ".join(arg_names)
                    param_list = " ".join(param_strs)
                    asserts.append(f"(assert (forall ({param_list}) (= ({name} {args}) {value})))")
        elif head == "define-const" and len(item) >= 4:
            name = sexpr_to_string(item[1])
            if name in excluded or (allowed and name not in allowed):
                continue
            value = sexpr_to_string(item[3])
            if contains_unknown_symbol(value, allowed):
                continue
            asserts.append(f"(assert (= {name} {value}))")
    return asserts


def contains_unknown_symbol(value: str, allowed: set[str]) -> bool:
    if not allowed:
        return False
    for tok in tokenize(value):
        if tok in {"(", ")"}:
            continue
        if tok.startswith('"') and tok.endswith('"'):
            continue
        if tok.lstrip("-").isdigit():
            continue
        if "!" in tok and tok not in allowed:
            return True
    return False


def insert_asserts_into_ra(content: str, asserts: List[str]) -> str:
    if not asserts:
        return content
    insert_text = "\n".join(asserts) + "\n"
    match = re.search(r"\(check-sat\)", content)
    if match:
        idx = match.start()
        return content[:idx] + insert_text + content[idx:]
    if content and not content.endswith("\n"):
        content += "\n"
    return content + insert_text + "(check-sat)\n"


def check_pair(
    uf_file: pathlib.Path,
    ra_file: pathlib.Path,
    timeout: int,
    save_dir: pathlib.Path,
    rel_path: pathlib.Path,
    only_zero_arity: bool,
) -> int:
    with tempfile.TemporaryDirectory() as tmpdir:
        tmpdir_path = pathlib.Path(tmpdir)
        uf_tmp = tmpdir_path / "uf_with_model.smt2"
        uf_content = uf_file.read_text()
        uf_with_model = insert_get_model(uf_content)
        uf_tmp.write_text(uf_with_model)
        
        # Try solvers in order until we get a SAT result with model
        uf_solver_used = None
        defs = []
        model_text = ""
        for solver in SOLVER_ORDER:
            status, stdout, stderr, _ = run_solver(uf_tmp, timeout, solver)
            if status == "sat":
                defs, model_text = extract_model_defs(stdout)
                if defs:  # Only accept if we got a valid model
                    uf_solver_used = solver
                    break
            elif status in {"error", "missing"}:
                print(f"UF solver {solver} error: {stderr.strip()}", file=sys.stderr)
        
        # If no solver returned SAT with valid model, skip RA verification
        if not uf_solver_used:
            ra_log_dir = save_dir / "ra_result"
            ra_log_path = ra_log_dir / rel_path
            ra_log_path.parent.mkdir(parents=True, exist_ok=True)
            ra_log_path.write_text(
                "status: skip\n"
                "solver: \n"
                "result: \n"
                "reason: No UF solver returned SAT with valid model\n"
            )
            return 3
        
        # Generate RA file with model constraints
        excluded = {
            "num_splits",
            "split_at",
            "split_rest",
            "split_rest_re",
            "num_splits_re",
            "split_at_re",
        }
        ra_content = ra_file.read_text()
        ra_normalized, ra_symbols = normalize_ra_and_symbols(ra_content)
        asserts = model_defs_to_asserts_filtered(defs, excluded, ra_symbols, only_zero_arity)
        final_ra = insert_asserts_into_ra(ra_normalized, asserts)
        
        # Save UF outputs
        uf_dir = save_dir / "uf_with_model"
        model_dir = save_dir / "model"
        ra_dir = save_dir / "ra_with_model"
        uf_path = uf_dir / rel_path
        model_path = model_dir / rel_path
        ra_path = ra_dir / rel_path
        uf_path.parent.mkdir(parents=True, exist_ok=True)
        model_path.parent.mkdir(parents=True, exist_ok=True)
        ra_path.parent.mkdir(parents=True, exist_ok=True)
        uf_path.write_text(uf_with_model)
        model_path.write_text((model_text + "\n") if model_text else "")
        ra_path.write_text(final_ra)
        
        # Try RA verification with solver fallback
        ra_tmp = tmpdir_path / "ra_with_model.smt2"
        ra_tmp.write_text(final_ra)
        
        ra_solver_used = None
        ra_status = None
        ra_stdout = ""
        ra_stderr = ""
        for solver in SOLVER_ORDER:
            ra_status, ra_stdout, ra_stderr, _ = run_solver(ra_tmp, timeout, solver)
            if ra_status in {"sat", "unsat"}:
                ra_solver_used = solver
                break
            elif ra_status in {"error", "missing"}:
                print(f"RA solver {solver} error: {ra_stderr.strip()}", file=sys.stderr)
        
        # Write RA result
        ra_log_dir = save_dir / "ra_result"
        ra_log_path = ra_log_dir / rel_path
        ra_log_path.parent.mkdir(parents=True, exist_ok=True)
        
        if ra_solver_used:
            final_status = "valid" if ra_status == "sat" else "invalid"
            ra_log_path.write_text(
                f"status: {final_status}\n"
                f"solver: {ra_solver_used}\n"
                f"result: {ra_status}\n"
                "stdout:\n"
                f"{ra_stdout}\n"
                "stderr:\n"
                f"{ra_stderr}\n"
            )
            return 0 if ra_status == "sat" else 1
        else:
            ra_log_path.write_text(
                "status: skip\n"
                "solver: \n"
                "result: \n"
                "reason: All RA solvers returned unknown/timeout\n"
            )
            return 3


def collect_pairs(uf_root: pathlib.Path, ra_root: pathlib.Path) -> Tuple[List[Tuple[pathlib.Path, pathlib.Path, pathlib.Path]], List[pathlib.Path]]:
    pairs: List[Tuple[pathlib.Path, pathlib.Path, pathlib.Path]] = []
    missing: List[pathlib.Path] = []
    for uf_path in sorted(uf_root.rglob("*.smt2")):
        rel = uf_path.relative_to(uf_root)
        ra_path = ra_root / rel
        if ra_path.is_file():
            pairs.append((uf_path, ra_path, rel))
        else:
            missing.append(rel)
    return pairs, missing


def main() -> int:
    args = parse_args()
    uf_input = args.uf_file.resolve()
    ra_input = args.ra_file.resolve()
    save_dir = args.save_dir.resolve()
    if args.timeout <= 0:
        print("Error: timeout must be positive", file=sys.stderr)
        return 2
    if save_dir.is_file():
        print(f"Error: save-dir must be a directory {save_dir}", file=sys.stderr)
        return 2
    if uf_input.is_file() and ra_input.is_file():
        if not uf_input.is_file():
            print(f"Error: uf file not found {uf_input}", file=sys.stderr)
            return 2
        if not ra_input.is_file():
            print(f"Error: ra file not found {ra_input}", file=sys.stderr)
            return 2
        result = check_pair(
            uf_input,
            ra_input,
            args.timeout,
            save_dir,
            pathlib.Path(ra_input.name),
            not args.all_arity,
        )
        if result == 3:
            print("skip")
            return 0
        print("valid" if result == 0 else "invalid")
        return 0 if result in {0, 1} else 2
    if uf_input.is_dir() and ra_input.is_dir():
        pairs, missing = collect_pairs(uf_input, ra_input)
        for rel in missing:
            print(f"Error: missing RA file {ra_input / rel}", file=sys.stderr)
        if not pairs and not missing:
            print("Error: no smt2 files found", file=sys.stderr)
            return 2

        has_invalid = False
        has_error = False

        with ProcessPoolExecutor(max_workers=args.jobs) as executor:
            future_to_file = {
                executor.submit(
                    check_pair,
                    uf_path,
                    ra_path,
                    args.timeout, # Renamed from args.ra_timeout
                    save_dir,
                    rel,
                    not args.all_arity,
                ): rel
                for uf_path, ra_path, rel in pairs
            }

            for future in as_completed(future_to_file):
                rel = future_to_file[future]
                try:
                    res = future.result()
                    if res == 3:
                        status = "skip"
                    else:
                        status = "valid" if res == 0 else "invalid"
                    print(f"{rel}: {status}")

                    if res == 1:
                        has_invalid = True
                    elif res == 2:
                        has_error = True
                except Exception as exc:
                    print(f"{rel} generated an exception: {exc}", file=sys.stderr)
                    has_error = True

        if has_error or missing:
            return 2
        return 0
    print("Error: uf and ra inputs must both be files or both be directories", file=sys.stderr)
    return 2


if __name__ == "__main__":
    sys.exit(main())