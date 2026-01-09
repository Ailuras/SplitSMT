(set-logic ALL)
; Scenario: CSV Processing
; Goal: process comma-separated fields, ensure correct field counts, detect empty fields.

; --- str_split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const X String)              ; entire CSV line
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const commas Int)
(declare-const len0 Int)
(declare-const len2 Int)

(assert (= delim ","))

; Preserve seed core structure: keep two negative regex constraints (mutated to CSV-flavored headers)
(assert (not (str.in_re X
  (re.++ (str.to_re "Host:")
        (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
        (str.to_re "ServerToolbar\u{a}")))))
(assert (not (str.in_re X
  (re.++ (re.* (re.union (str.to_re "(") (str.to_re ")") (re.range "+" ".") (re.range "0" "9")))
        (str.to_re "\u{a}")))))

; CSV split structure
(assert (>= (num_splits X delim) 1))
(assert (<= (num_splits X delim) 10))

(assert (= f0 (split_at X delim 0)))
(assert (= f1 (split_at X delim 1)))
(assert (= f2 (split_at X delim 2)))
(assert (= f3 (split_at X delim 3)))
(assert (= rest1 (split_rest X delim 1)))
(assert (= rest2 (split_rest X delim 2)))

; Valid index bounds (natural indices)
(assert (>= commas 0))

; Count constraints: enforce exactly 4 fields => 4 segments => 3 commas
(assert (= (num_splits X delim) 4))
(assert (= commas (- (num_splits X delim) 1)))

; Reconstructability for first two splits
(assert (= X (str.++ f0 delim rest1)))
(assert (= rest1 (str.++ f1 delim rest2)))

; Detect and constrain empty fields: ensure field1 is empty, field0 is non-empty
(assert (= f1 ""))
(assert (not (= f0 "")))

; Forbid embedded commas inside a field (simplified CSV: no quoting)
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; Forbid newlines in the record (single-line CSV)
(assert (not (str.contains X "\u{a}")))
(assert (not (str.contains X "\u{d}")))

; Length-related constraints on selected fields
(assert (= len0 (str.len f0)))
(assert (= len2 (str.len f2)))
(assert (>= len0 1))
(assert (>= len2 0))

; Mix in a complex pattern: field0 must look like an identifier, field2 must be digits-only.
(assert (str.in_re f0 (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_"))))))
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))

; --- UNSAT branch embedded as a conditional inconsistency (forces UNSAT) ---
; Require field1 to be both empty and non-empty.
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]