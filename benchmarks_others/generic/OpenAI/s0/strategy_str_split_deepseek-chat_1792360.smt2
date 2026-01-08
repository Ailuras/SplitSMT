(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; Scenario: CSV Processing
; Goal: ensure correct field counts and detect empty fields
; Create both SAT and UNSAT instances in one file via a selector.
; -----------------------------

(declare-const mode Int)

(declare-const csv_line String)
(declare-const delim String)

(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const f4 String)

(declare-const rest2 String)
(declare-const rest3 String)

; Basic delimiter setup
(assert (= delim ","))

; Indices are natural
(assert (and (<= 0 mode) (<= mode 1)))

; Split-derived fields and suffixes
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= f3 (split_at csv_line delim 3)))
(assert (= f4 (split_at csv_line delim 4)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Shared CSV well-formedness constraints
(assert (>= (num_splits csv_line delim) 1))
(assert (>= (num_splits csv_line delim) 3))

; Detect empty fields (use exact emptiness checks)
(declare-const has_empty Bool)
(assert (= has_empty (or (= f0 "") (= f1 "") (= f2 "") (= f3 "") (= f4 ""))))

; Mix in additional realistic constraints: disallow commas inside fields, trim-like property (no leading/trailing spaces)
(declare-const sp String)
(assert (= sp " "))

(declare-const no_commas_in_f0 Bool)
(declare-const no_commas_in_f1 Bool)
(declare-const no_commas_in_f2 Bool)
(assert (= no_commas_in_f0 (not (str.contains f0 delim))))
(assert (= no_commas_in_f1 (not (str.contains f1 delim))))
(assert (= no_commas_in_f2 (not (str.contains f2 delim))))
(assert (and no_commas_in_f0 no_commas_in_f1 no_commas_in_f2))

; Light whitespace hygiene on first three fields
(assert (or (= f0 "") (not (= (str.at f0 0) sp))))
(assert (or (= f1 "") (not (= (str.at f1 0) sp))))
(assert (or (= f2 "") (not (= (str.at f2 0) sp))))
(assert (or (= f0 "") (not (= (str.at f0 (- (str.len f0) 1)) sp))))
(assert (or (= f1 "") (not (= (str.at f1 (- (str.len f1) 1)) sp))))
(assert (or (= f2 "") (not (= (str.at f2 (- (str.len f2) 1)) sp))))

; Ensure index bounds when using str.at with (- (str.len s) 1)
(assert (or (= f0 "") (>= (str.len f0) 1)))
(assert (or (= f1 "") (>= (str.len f1) 1)))
(assert (or (= f2 "") (>= (str.len f2) 1)))

; -----------------------------
; SAT branch (mode = 0): exactly 4 fields, allow an empty middle field (e.g., "A,,C,D")
; -----------------------------
(declare-const sat_ok Bool)
(assert (= sat_ok
  (and
    (= (num_splits csv_line delim) 4)
    (= f0 "A")
    (= f1 "")
    (= f2 "C")
    (= f3 "D")
    has_empty
    (= rest2 (str.++ f2 delim f3))
    (= rest3 f3)
  )))

; -----------------------------
; UNSAT branch (mode = 1): claim exactly 3 fields but force an additional split segment
; Additionally require no empty fields, yet force an empty one.
; -----------------------------
(declare-const unsat_bad Bool)
(assert (= unsat_bad
  (and
    (= (num_splits csv_line delim) 3)
    ; Force at least 4 segments simultaneously (contradiction with =3)
    (>= (num_splits csv_line delim) 4)
    ; No empty fields, but force emptiness
    (not has_empty)
    (= f1 "")
  )))

; Mode selects which instance is active
(assert (ite (= mode 0) sat_ok unsat_bad))

(check-sat)


; [GENERATION STATUS: SUCCESS]
