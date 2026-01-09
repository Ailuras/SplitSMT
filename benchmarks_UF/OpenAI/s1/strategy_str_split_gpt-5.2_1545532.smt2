(set-logic ALL)

; Scenario: CSV Processing
; Goal: Process comma-separated data fields to ensure correct field counts and detect empty fields.

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core input CSV line
(declare-const X String)

; Delimiter
(declare-const delim String)
(assert (= delim ","))

; Derived fields
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)

; Indices (natural)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))
(assert (>= k0 0))
(assert (>= k1 0))
(assert (>= k2 0))

; Preserve core structure: keep a reference to the original seed pattern as an allowed form
; (but extend to CSV forms; X may still equal this exact string)
(assert (or (= X "WindowsAcmeReferer:\n")
            (str.contains X ",")))

; CSV must have at least 3 segments (2 commas)
(assert (>= (num_splits X delim) 3))

; Bind split projections
(assert (= f0 (split_at X delim k0)))
(assert (= f1 (split_at X delim k1)))
(assert (= f2 (split_at X delim k2)))
(assert (= rest1 (split_rest X delim k1)))

; Field-count sanity: rest from index 1 should be non-empty if at least 2 segments
(assert (=> (>= (num_splits X delim) 2)
            (> (str.len rest1) 0)))

; Detect an empty middle field (e.g., "a,,b")
(assert (= f1 ""))

; Ensure first and third fields are non-empty and have no commas
(assert (> (str.len f0) 0))
(assert (> (str.len f2) 0))
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f2 delim)))

; Require the line to start with the first field followed by a comma
(assert (str.prefixof (str.++ f0 delim) X))

; --- UNSAT corner-case constraints (intentional contradiction) ---
; If f1 is empty, X must contain consecutive commas at the position between f0 and f2.
(assert (str.contains X ",,"))
; Contradiction: also forbid consecutive commas.
(assert (not (str.contains X ",,")))

(check-sat)


; [GENERATION STATUS: SUCCESS]