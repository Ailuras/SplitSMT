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

; Uninterpreted interface operations for str_split

; -----------------------------
; Scenario: CSV Processing
; -----------------------------

; SAT instance: A CSV line with exactly 4 fields, one empty field in the middle, and no trailing commas
(declare-const csv_line_sat String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= f0_sat (split_at csv_line_sat "," 0)))
(assert (= f1_sat (split_at csv_line_sat "," 1)))
(assert (= f2_sat (split_at csv_line_sat "," 2)))
(assert (= f3_sat (split_at csv_line_sat "," 3)))

; exactly 4 fields
(assert (= (num_splits csv_line_sat ",") 4))

; include an empty field at index 1
(assert (= f1_sat ""))

; basic non-empty constraints for other fields
(assert (>= (str.len f0_sat) 1))
(assert (>= (str.len f2_sat) 1))
(assert (>= (str.len f3_sat) 1))

; no commas inside any single field (simple CSV, no quoting)
(assert (not (str.contains f0_sat ",")))
(assert (not (str.contains f1_sat ",")))
(assert (not (str.contains f2_sat ",")))
(assert (not (str.contains f3_sat ",")))

; relate line structure using split_rest (soft structural consistency constraints)
(assert (= rest2_sat (split_rest csv_line_sat "," 2)))
(assert (= rest3_sat (split_rest csv_line_sat "," 3)))
(assert (= rest2_sat (str.++ f2_sat "," f3_sat)))
(assert (= rest3_sat f3_sat))

; ensure there are commas in the original line for 4 fields
(assert (str.contains csv_line_sat ","))


; UNSAT instance: Force contradictory properties about empty fields / trailing comma
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)

(assert (= u0 (split_at csv_line_unsat "," 0)))
(assert (= u1 (split_at csv_line_unsat "," 1)))
(assert (= u2 (split_at csv_line_unsat "," 2)))

; exactly 3 fields
(assert (= (num_splits csv_line_unsat ",") 3))

; claim there is a trailing comma, which would create an empty last field in typical split semantics
(assert (str.contains csv_line_unsat ","))
(assert (= (str.at csv_line_unsat (- (str.len csv_line_unsat) 1)) ","))

; but also force the last field to be non-empty -> intended contradiction under split constraints
(assert (>= (str.len u2) 1))

; additionally, force all fields to be non-empty, contradicting empty-last-field expectation
(assert (>= (str.len u0) 1))
(assert (>= (str.len u1) 1))




; [GENERATION STATUS: SUCCESS]
(assert (= csv_line_sat ","))
(assert (= csv_line_unsat ",,"))
(assert (= rest2_sat "G,F"))
(assert (= rest3_sat "F"))
(assert (= u0 "D"))
(assert (= f3_sat "F"))
(assert (= f0_sat "E"))
(assert (= f1_sat ""))
(assert (= u2 "C"))
(assert (= f2_sat "G"))
(assert (= u1 "A"))
(check-sat)
(exit)
