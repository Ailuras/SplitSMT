(set-logic ALL)

; Uninterpreted interface functions for string splitting

; -----------------------------
; Scenario: CSV Processing
; Goal: enforce field counts, detect empty fields, mix SAT and UNSAT subcases
; -----------------------------

; A SAT instance: a simple 4-field CSV row with no empty fields
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)

(assert (= csv_row_sat (str.++ f0_sat "," f1_sat "," f2_sat "," f3_sat)))
(assert (= (str.num_splits csv_row_sat ",") 4))
(assert (= f0_sat (str.split_at csv_row_sat "," 0)))
(assert (= f1_sat (str.split_at csv_row_sat "," 1)))
(assert (= f2_sat (str.split_at csv_row_sat "," 2)))
(assert (= f3_sat (str.split_at csv_row_sat "," 3)))
(assert (= (str.split_rest csv_row_sat "," 2) (str.++ f2_sat "," f3_sat)))

; No empty fields in SAT row
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; Restrict fields to not contain commas (typical unquoted CSV simplifying assumption)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; Additional sanity: first field looks like an identifier (letters/underscore, then letters/digits/underscore)
(declare-const id_re RegLan)
(assert (= id_re (re.++ (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z"))
                        (re.* (re.union (str.to_re "_") (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))))))
(assert (str.in_re f0_sat id_re))

; -----------------------------
; Another SAT instance: detect an empty field (consecutive commas)
; Here we ensure there are 5 fields and one is empty
(declare-const csv_row_empty_sat String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e3 String)
(declare-const e4 String)

(assert (= csv_row_empty_sat (str.++ e0 "," e1 "," e2 "," e3 "," e4)))
(assert (= (str.num_splits csv_row_empty_sat ",") 5))
(assert (= e0 (str.split_at csv_row_empty_sat "," 0)))
(assert (= e1 (str.split_at csv_row_empty_sat "," 1)))
(assert (= e2 (str.split_at csv_row_empty_sat "," 2)))
(assert (= e3 (str.split_at csv_row_empty_sat "," 3)))
(assert (= e4 (str.split_at csv_row_empty_sat "," 4)))

; Detect at least one empty field; pin it to e2 for concreteness
(assert (= e2 ""))

; Ensure others are non-empty and comma-free
(assert (> (str.len e0) 0))
(assert (> (str.len e1) 0))
(assert (> (str.len e3) 0))
(assert (> (str.len e4) 0))
(assert (not (str.contains e0 ",")))
(assert (not (str.contains e1 ",")))
(assert (not (str.contains e3 ",")))
(assert (not (str.contains e4 ",")))

; The row must contain ",," somewhere to witness an empty field
(assert (str.contains csv_row_empty_sat ",,"))

; -----------------------------
; An UNSAT instance: claims a 3-field CSV but also forces an empty middle field while forbidding ",,"
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= csv_row_unsat (str.++ u0 "," u1 "," u2)))
(assert (= (str.num_splits csv_row_unsat ",") 3))
(assert (= u0 (str.split_at csv_row_unsat "," 0)))
(assert (= u1 (str.split_at csv_row_unsat "," 1)))
(assert (= u2 (str.split_at csv_row_unsat "," 2)))

; Force middle field empty => row must contain ",,"
(assert (= u1 ""))

; Contradiction: forbid consecutive commas
(assert (not (str.contains csv_row_unsat ",,")))

; Also require u0 and u2 are non-empty (to avoid trivialities like leading/trailing commas explanations)
(assert (> (str.len u0) 0))
(assert (> (str.len u2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
