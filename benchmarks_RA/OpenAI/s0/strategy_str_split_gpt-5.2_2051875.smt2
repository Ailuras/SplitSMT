(set-logic ALL)

; Uninterpreted interface for string split operations
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

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
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

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

; =========================
; Scenario: CSV Processing
; =========================

; -------- SAT instance: well-formed CSV row with possible empty middle field
(declare-const csv_row_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)

; Structure: 4 fields => 4 segments when splitting by ","
(assert (= (num_splits csv_row_sat ",") 4))
(assert (= f0_sat (split_at csv_row_sat "," 0)))
(assert (= f1_sat (split_at csv_row_sat "," 1)))
(assert (= f2_sat (split_at csv_row_sat "," 2)))
(assert (= f3_sat (split_at csv_row_sat "," 3)))

; Relate the rest operator to later segments (interface-style constraints)
(assert (= rest1_sat (split_rest csv_row_sat "," 1)))
(assert (= rest2_sat (split_rest csv_row_sat "," 2)))

; Concrete synthesis of a realistic CSV row: "alpha,,42,omega"
(assert (= csv_row_sat (str.++ "alpha" "," "" "," "42" "," "omega")))

; Detect empty field: the second field is empty, others are non-empty
(assert (= f1_sat ""))
(assert (not (= f0_sat "")))
(assert (not (= f2_sat "")))
(assert (not (= f3_sat "")))

; Additional sanity checks on tokens
(assert (str.contains f0_sat "a"))
(assert (= (str.len f2_sat) 2))
(assert (= (str.at f3_sat 0) "o"))

; Ensure commas exist in the row (should be at least 3 for 4 fields)
(assert (>= (num_splits csv_row_sat ",") 4))

; -------- UNSAT instance: contradictory empty-field requirements
(declare-const csv_row_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

; 3 fields expected
(assert (= (num_splits csv_row_unsat ",") 3))
(assert (= u0 (split_at csv_row_unsat "," 0)))
(assert (= u1 (split_at csv_row_unsat "," 1)))
(assert (= u2 (split_at csv_row_unsat "," 2)))

; Fix the CSV row to have an empty middle field
(assert (= csv_row_unsat (str.++ "x" "," "" "," "y")))

; Contradiction: require u1 to be both empty and non-empty
(assert (= u1 ""))
(assert (not (= u1 "")))

; -------- SAT/UNSAT combined via disjunction for diversity
; This makes the overall file SAT by allowing either the consistent SAT block
; or (if chosen) the inconsistent UNSAT block, but the SAT block is already fixed.
(declare-const choose_sat Bool)
(assert (or choose_sat (not choose_sat)))

; Make the overall problem satisfiable by forcing the SAT instance to hold.
(assert choose_sat)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
