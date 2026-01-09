(set-logic ALL)

; Uninterpreted interface for string split operations

; =====================
; SAT instance: CSV line with empty fields allowed, ensure field count and positions
; =====================
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_fields Int)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail_from2 String)

(assert (= delim ","))
(assert (= csv_line_sat "alice,,42,NY"))

; Expect exactly 4 fields (including empty field between consecutive commas)
(assert (= sat_fields (str.num_splits csv_line_sat delim)))
(assert (= sat_fields 4))

(assert (= sat_f0 (str.split_at csv_line_sat delim 0)))
(assert (= sat_f1 (str.split_at csv_line_sat delim 1)))
(assert (= sat_f2 (str.split_at csv_line_sat delim 2)))
(assert (= sat_f3 (str.split_at csv_line_sat delim 3)))

; Field content checks: detect empty second field
(assert (= sat_f0 "alice"))
(assert (= sat_f1 ""))
(assert (= sat_f2 "42"))
(assert (= sat_f3 "NY"))

; Additional structural check via split_rest
(assert (= sat_tail_from2 (str.split_rest csv_line_sat delim 2)))
(assert (= sat_tail_from2 "42,NY"))

; Basic index/domain constraints for split operations
(assert (>= sat_fields 1))

(check-sat)

; =====================
; UNSAT instance: claim a line has 3 fields but enforce it has an empty 4th field
; =====================
(declare-const csv_line_unsat String)
(declare-const uns_fields Int)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)
(declare-const uns_f3 String)

(assert (= csv_line_unsat "a,b,c,"))

; Contradictory expectations: require 3 splits but also require a 4th empty field exists
(assert (= uns_fields (str.num_splits csv_line_unsat delim)))
(assert (= uns_fields 3))

(assert (= uns_f0 (str.split_at csv_line_unsat delim 0)))
(assert (= uns_f1 (str.split_at csv_line_unsat delim 1)))
(assert (= uns_f2 (str.split_at csv_line_unsat delim 2)))
(assert (= uns_f3 (str.split_at csv_line_unsat delim 3)))

(assert (= uns_f0 "a"))
(assert (= uns_f1 "b"))
(assert (= uns_f2 "c"))
(assert (= uns_f3 ""))

; Interface-style bounds (natural indices); uns_f3 implies at least 4 fields
(assert (>= (str.num_splits csv_line_unsat delim) 4))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
