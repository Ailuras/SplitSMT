(set-logic ALL)

; Uninterpreted functions for string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; =========================
; Scenario: CSV Processing
; =========================

; --------
; SAT part
; --------
(declare-const csv_line String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail1 String)
(declare-const tail2 String)
(declare-const tail3 String)
(declare-const total_fields Int)
(declare-const idx0 Int)
(declare-const idx1 Int)
(declare-const idx2 Int)
(declare-const idx3 Int)

(assert (= comma ","))

; Model a 4-field CSV row: f0,f1,f2,f3
(assert (= total_fields (num_splits csv_line comma)))
(assert (= total_fields 4))

; Indices are natural and within the valid segment range
(assert (= idx0 0))
(assert (= idx1 1))
(assert (= idx2 2))
(assert (= idx3 3))
(assert (and (<= 0 idx0) (< idx0 total_fields)))
(assert (and (<= 0 idx1) (< idx1 total_fields)))
(assert (and (<= 0 idx2) (< idx2 total_fields)))
(assert (and (<= 0 idx3) (< idx3 total_fields)))

; Extract fields via split_at
(assert (= f0 (split_at csv_line comma idx0)))
(assert (= f1 (split_at csv_line comma idx1)))
(assert (= f2 (split_at csv_line comma idx2)))
(assert (= f3 (split_at csv_line comma idx3)))

; Track remaining suffixes for additional structure
(assert (= tail1 (split_rest csv_line comma 1)))
(assert (= tail2 (split_rest csv_line comma 2)))
(assert (= tail3 (split_rest csv_line comma 3)))

; Basic consistency expectations (relaxation-friendly): tails should be substrings of the line
(assert (str.contains csv_line tail1))
(assert (str.contains csv_line tail2))
(assert (str.contains csv_line tail3))

; Detect empty fields: at least one field is empty, and at least one is non-empty
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; Simple CSV hygiene: no field contains an unescaped comma (approximated by forbidding comma in fields)
(assert (not (str.contains f0 comma)))
(assert (not (str.contains f1 comma)))
(assert (not (str.contains f2 comma)))
(assert (not (str.contains f3 comma)))

; Add concrete content constraints to keep it obviously satisfiable
(assert (= f0 "id"))
(assert (= f2 "42"))
; allow f1 to be empty to represent missing name
(assert (= f1 ""))
; allow f3 to be non-empty
(assert (= f3 "ok"))

; Optional format constraints on numeric field f2: only digits via regex
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))

; Ensure line has commas somewhere
(assert (str.contains csv_line comma))
; Keep line non-empty
(assert (> (str.len csv_line) 0))

; ----------
; UNSAT part
; ----------
; A second line with contradictory requirements: exactly 3 fields but also claims 4th field is non-empty.
(declare-const csv_line_bad String)
(declare-const bad_fields Int)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)
(declare-const b3 String)

(assert (= bad_fields (num_splits csv_line_bad comma)))
(assert (= bad_fields 3))

; Extracting b3 at index 3 is forced to be in-range by the following, contradicting bad_fields=3.
(assert (= b0 (split_at csv_line_bad comma 0)))
(assert (= b1 (split_at csv_line_bad comma 1)))
(assert (= b2 (split_at csv_line_bad comma 2)))
(assert (= b3 (split_at csv_line_bad comma 3)))

; Interface index bounds (enforced for this bad instance)
(assert (and (<= 0 3) (< 3 bad_fields)))

; Additional constraints to make the contradiction independent of string content
(assert (not (= b3 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
