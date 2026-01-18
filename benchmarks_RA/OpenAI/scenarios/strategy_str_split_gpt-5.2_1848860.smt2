(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

; Uninterpreted interface for string split

; =========================
; Scenario: CSV Processing
; =========================

; ---------- SAT instance: basic validation, field count, empty-field detection ----------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const empty_count_sat Int)

(assert (= delim ","))

; Require exactly 4 fields (segments) separated by commas
(assert (= (num_splits csv_line_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Rest from index 1 onward
(assert (= rest1_sat (split_rest csv_line_sat delim 1)))

; Concrete shape example with an empty middle field: "alpha,,gamma,delta"
(assert (= csv_line_sat (str.++ "alpha" delim "" delim "gamma" delim "delta")))

; Basic content constraints: no commas inside fields (approximation using contains)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; Detect empties: count how many fields have length 0
(assert (= empty_count_sat
  (+ (ite (= (str.len f0_sat) 0) 1 0)
     (ite (= (str.len f1_sat) 0) 1 0)
     (ite (= (str.len f2_sat) 0) 1 0)
     (ite (= (str.len f3_sat) 0) 1 0))))

; Ensure exactly one empty field
(assert (= empty_count_sat 1))

; Additional sanity: first field non-empty, last field non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f3_sat) 0))

; Ensure rest1 starts with the second field (weak check: if f1 is non-empty, it occurs in rest1)
(assert (=> (> (str.len f1_sat) 0) (str.contains rest1_sat f1_sat)))

; ---------- UNSAT instance: contradictory requirements on emptiness vs concrete string ----------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)
(declare-const g3_unsat String)
(declare-const empty_count_unsat Int)

(assert (= (num_splits csv_line_unsat delim) 4))
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))
(assert (= g3_unsat (split_at csv_line_unsat delim 3)))

; Concrete CSV with no empty fields: "a,b,c,d"
(assert (= csv_line_unsat (str.++ "a" delim "b" delim "c" delim "d")))

(assert (= empty_count_unsat
  (+ (ite (= (str.len g0_unsat) 0) 1 0)
     (ite (= (str.len g1_unsat) 0) 1 0)
     (ite (= (str.len g2_unsat) 0) 1 0)
     (ite (= (str.len g3_unsat) 0) 1 0))))

; Contradiction: demand at least one empty field
(assert (>= empty_count_unsat 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
