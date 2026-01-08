(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ========== SAT instance: CSV processing with correct field counts and empty-field detection ==========
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const empty_count_sat Int)
(declare-const is_empty1_sat Bool)

(assert (= delim ","))

; Enforce exactly 4 fields
(assert (= (num_splits csv_line_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Remainder views
(assert (= rest1_sat (split_rest csv_line_sat delim 1)))
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))

; Make a concrete CSV line via concatenation to witness SAT
; Example: "id,,42,OK" (second field is empty)
(assert (= csv_line_sat (str.++ "id" "," "" "," "42" "," "OK")))

; Detect an empty field (field 1) and ensure others are non-empty
(assert (= is_empty1_sat (= f1_sat "")))
(assert is_empty1_sat)
(assert (not (= f0_sat "")))
(assert (not (= f2_sat "")))
(assert (not (= f3_sat "")))

; Count empty fields among f0..f3 (here exactly 1)
(assert (= empty_count_sat
  (+ (ite (= f0_sat "") 1 0)
     (ite (= f1_sat "") 1 0)
     (ite (= f2_sat "") 1 0)
     (ite (= f3_sat "") 1 0))))
(assert (= empty_count_sat 1))

; Sanity: no delimiter inside fields (simple CSV assumption)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; Additional constraint: third field is numeric-like (only digits, non-empty)
(assert (> (str.len f2_sat) 0))
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))

; Keep segment indices natural
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

(check-sat)

; ========== UNSAT instance: contradictory requirements on empty fields / field count ==========
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)
(declare-const g3_unsat String)
(declare-const empty_count_unsat Int)

; Require exactly 4 fields
(assert (= (num_splits csv_line_unsat delim) 4))

; Extract fields
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))
(assert (= g3_unsat (split_at csv_line_unsat delim 3)))

; Define empty count
(assert (= empty_count_unsat
  (+ (ite (= g0_unsat "") 1 0)
     (ite (= g1_unsat "") 1 0)
     (ite (= g2_unsat "") 1 0)
     (ite (= g3_unsat "") 1 0))))

; Contradiction: all fields non-empty but empty_count = 2
(assert (not (= g0_unsat "")))
(assert (not (= g1_unsat "")))
(assert (not (= g2_unsat "")))
(assert (not (= g3_unsat "")))
(assert (= empty_count_unsat 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
