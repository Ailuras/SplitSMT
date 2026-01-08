(set-logic ALL)

; Scenario: CSV Processing
; Goal: Constrain a CSV line with comma-separated numeric fields,
; ensure correct field counts, and detect empty fields.

; --- str_split interface (uninterpreted, per methodology) ---

; --- Variables ---
(declare-const s String)            ; CSV line
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const delim String)

; --- Delimiter ---
(assert (= delim ","))

; --- Core split structure ---
(assert (= f0 (str.split_at s delim 0)))
(assert (= f1 (str.split_at s delim 1)))
(assert (= f2 (str.split_at s delim 2)))
(assert (= f3 (str.split_at s delim 3)))
(assert (= rest2 (str.split_rest s delim 2)))

; --- Field count: require exactly 4 fields (3 commas) ---
(assert (= (str.num_splits s delim) 4))

; --- Non-empty line and length bounds (CSV line small) ---
(assert (not (= (str.len s) 0)))
(assert (<= (str.len s) 32))

; --- Ensure there are commas and avoid trailing/leading comma (no empty edge field) ---
(assert (not (str.prefixof delim s)))
(assert (not (str.suffixof delim s)))

; --- Field format constraints: numeric fields only ---
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))
(assert (str.in_re f1 (re.+ (re.range "0" "9"))))
(assert (str.in_re f2 (re.+ (re.range "0" "9"))))
(assert (str.in_re f3 (re.+ (re.range "0" "9"))))

; --- Detect empty fields (make at least one field empty) ---
; This contradicts the numeric regex requirements above, creating an UNSAT instance.
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; --- Extra consistency constraints resembling seed-style checks ---
(assert (not (= (str.len f0) 1)))
(assert (not (= (str.at f0 0) "0")))

; Numeric range checks on two fields (if conversion fails, str.to_int returns -1)
(assert (and (>= (str.to_int f1) 0) (<= (str.to_int f1) 255)))
(assert (and (>= (str.to_int f2) 0) (<= (str.to_int f2) 255)))

; Ensure rest from index 2 contains at least one comma separating f2 and f3
(assert (str.contains rest2 delim))

(check-sat)


; [GENERATION STATUS: SUCCESS]
