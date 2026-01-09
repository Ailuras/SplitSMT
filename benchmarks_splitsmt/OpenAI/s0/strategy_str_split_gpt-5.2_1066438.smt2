(set-logic ALL)

; Uninterpreted split interface

; =========================
; SAT instance: CSV row processing
; =========================
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail_from_2 String)
(declare-const header String)

(assert (= delim ","))

; Require exactly 4 fields (segments) after splitting on comma
(assert (= (str.num_splits csv_line delim) 4))

; Extract fields
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= f3 (str.split_at csv_line delim 3)))

; Basic schema constraints
; Field0: non-empty identifier with no commas
(assert (> (str.len f0) 0))
(assert (not (str.contains f0 delim)))

; Field1: may be empty (detect empty field), still cannot contain commas
(assert (not (str.contains f1 delim)))

; Field2: integer-like: optional leading '-', then digits only
(assert (str.in_re f2 (re.++ (re.opt (str.to_re "-")) (re.+ (re.range "0" "9")))))

; Field3: must be non-empty and contain no commas
(assert (> (str.len f3) 0))
(assert (not (str.contains f3 delim)))

; Ensure csv_line reconstructs from pieces with commas (one possible well-formedness axiom)
(assert (= csv_line (str.++ f0 delim f1 delim f2 delim f3)))

; Also use split_rest: tail from index 2 should be f2,f3
(assert (= tail_from_2 (str.split_rest csv_line delim 2)))
(assert (= tail_from_2 (str.++ f2 delim f3)))

; Detect empty field1: enforce it empty in this SAT instance
(assert (= f1 ""))

; Add a prefix-like requirement: a header tag must appear in field0
(assert (= header "ID"))
(assert (str.contains f0 header))

; =========================
; UNSAT instance: contradictory CSV requirements
; =========================
(declare-const bad_csv String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= (str.num_splits bad_csv delim) 3))
(assert (= g0 (str.split_at bad_csv delim 0)))
(assert (= g1 (str.split_at bad_csv delim 1)))
(assert (= g2 (str.split_at bad_csv delim 2)))

; Force an explicit reconstruction with exactly two commas
(assert (= bad_csv (str.++ g0 delim g1 delim g2)))

; Contradiction: require g1 both empty and non-empty
(assert (= g1 ""))
(assert (> (str.len g1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
