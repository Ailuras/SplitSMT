(set-logic ALL)

; Uninterpreted interface functions for str_split

; Scenario 1 (SAT): CSV processing with 4 fields, detects an empty third field
(declare-const csv1 String)
(declare-const f1_0 String)
(declare-const f1_1 String)
(declare-const f1_2 String)
(declare-const f1_3 String)
(declare-const tail1_2 String)
(declare-const tail1_3 String)

(assert (= csv1 "alpha,beta,,delta"))
(assert (= (str.num_splits csv1 ",") 4))
(assert (= f1_0 (str.split_at csv1 "," 0)))
(assert (= f1_1 (str.split_at csv1 "," 1)))
(assert (= f1_2 (str.split_at csv1 "," 2)))
(assert (= f1_3 (str.split_at csv1 "," 3)))

; Field content expectations
(assert (= f1_0 "alpha"))
(assert (= f1_1 "beta"))
(assert (= f1_2 ""))
(assert (= f1_3 "delta"))

; Rest-from-k constraints and consistency checks
(assert (= tail1_2 (str.split_rest csv1 "," 2)))
(assert (= tail1_3 (str.split_rest csv1 "," 3)))
(assert (= tail1_2 ",delta"))
(assert (= tail1_3 "delta"))
(assert (str.contains csv1 ",,"))
(assert (>= (str.len f1_3) 1))

; Index domain constraints (natural and within segment count)
(assert (and (<= 0 0) (< 0 (str.num_splits csv1 ","))))
(assert (and (<= 0 1) (< 1 (str.num_splits csv1 ","))))
(assert (and (<= 0 2) (< 2 (str.num_splits csv1 ","))))
(assert (and (<= 0 3) (< 3 (str.num_splits csv1 ","))))

; Additional CSV sanity: no whitespace inside fields for this row
(assert (not (str.contains f1_0 " ")))
(assert (not (str.contains f1_1 " ")))
(assert (not (str.contains f1_3 " ")))

(check-sat)

; Scenario 2 (UNSAT): contradictory constraints about empty field vs non-empty
(declare-const csv2 String)
(declare-const g2_0 String)
(declare-const g2_1 String)
(declare-const g2_2 String)
(declare-const g2_3 String)

(assert (= csv2 "a,b,c,d"))
(assert (= (str.num_splits csv2 ",") 4))
(assert (= g2_2 (str.split_at csv2 "," 2)))

; Contradiction: third field is "c" but also required to be empty
(assert (= g2_2 "c"))
(assert (= g2_2 ""))

(check-sat)
(exit)
