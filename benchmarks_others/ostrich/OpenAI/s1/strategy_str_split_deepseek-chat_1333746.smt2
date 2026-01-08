(set-logic ALL)

; Scenario: CSV Processing
; Core idea: Process comma-separated fields, ensure correct field counts and detect empty fields.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Variables ---
(declare-const X String)              ; entire CSV line including trailing newline
(declare-const csv String)            ; CSV content without newline
(declare-const delimiter String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const idx Int)

; Preserve the seed's core structural constraint: X ends with newline and begins with optional "BG" followed by 9 or 10 digits.
(assert (str.in_re X
  (re.++
    (re.opt (str.to_re "BG"))
    (re.union
      ((_ re.loop 9 9) (re.range "0" "9"))
      ((_ re.loop 10 10) (re.range "0" "9")))
    (str.to_re "\u{a}"))))

; Keep the seed's negative constraint (not containing a specific filename pattern).
(assert (not (str.in_re X
  (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".xpm/i\u{a}")))))

; CSV-specific: separate newline; csv is X without final \n.
(assert (> (str.len X) 0))
(assert (= (str.at X (- (str.len X) 1)) "\u{a}"))
(assert (= csv (str.substr X 0 (- (str.len X) 1))))

; CSV delimiter setup
(assert (= delimiter ","))

; Basic well-formedness: CSV contains commas, no embedded newlines.
(assert (str.contains csv delimiter))
(assert (not (str.contains csv "\u{a}")))

; Use str_split to talk about fields.
(assert (>= (num_splits csv delimiter) 2))
(assert (= f0 (split_at csv delimiter 0)))
(assert (= f1 (split_at csv delimiter 1)))
(assert (= rest2 (split_rest csv delimiter 2)))

; Field constraints: allow detecting empty field; at least one of first two fields must be empty.
(assert (or (= f0 "") (= f1 "")))

; But also require that the line is not trivially all empty segments.
(assert (or (> (str.len f0) 0) (> (str.len f1) 0) (> (str.len rest2) 0)))

; Require a fixed number of fields: exactly 4 fields (3 commas) is typical in CSV.
(assert (= (num_splits csv delimiter) 4))
(assert (= f2 (split_at csv delimiter 2)))
(assert (= f3 (split_at csv delimiter 3)))

; Field content restrictions using regex: f2 must be digits only (possibly empty), f3 must be non-empty alphabetic token.
(assert (str.in_re f2 (re.* (re.range "0" "9"))))
(assert (str.in_re f3 (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Index constraint: show natural index usage for split_at; keep within bounds.
(assert (= idx 1))
(assert (and (<= 0 idx) (< idx (num_splits csv delimiter))))
(assert (= (split_at csv delimiter idx) f1))

; UNSAT sub-instance embedded as an additional requirement: cannot have exactly 4 fields and simultaneously fewer than 3.
; This makes the overall instance UNSAT while still representing the CSV processing scenario.
(assert (< (num_splits csv delimiter) 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
