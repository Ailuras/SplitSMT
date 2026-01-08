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

; Uninterpreted interface for string splitting

; =====================
; Scenario: CSV Processing
; - Ensure correct field counts
; - Detect empty fields
; =====================

; ---------- SAT instance: a 4-field CSV line with a known empty field ----------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= delim ","))

; Enforce exactly 4 fields
(assert (= (num_splits csv_line_sat delim) 4))

; Project fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Rest from index 2
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))

; Concrete shape: "alpha,,42,omega" (empty second field)
(assert (= f0_sat "alpha"))
(assert (= f1_sat ""))
(assert (= f2_sat "42"))
(assert (= f3_sat "omega"))

; Non-empty constraints on other fields
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f2_sat) 0))
(assert (> (str.len f3_sat) 0))

; The remainder from 2 should include commas and end with last field
(assert (str.contains rest2_sat ","))
(assert (str.contains rest2_sat f3_sat))

; ---------- UNSAT instance: contradictory constraints about empty-field existence ----------
(declare-const csv_line_unsat String)
(declare-const f0_u String)
(declare-const f1_u String)
(declare-const f2_u String)
(declare-const has_empty_u Bool)

; Exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))

(assert (= f0_u (split_at csv_line_unsat delim 0)))
(assert (= f1_u (split_at csv_line_unsat delim 1)))
(assert (= f2_u (split_at csv_line_unsat delim 2)))

; Define a helper boolean capturing whether any field is empty
(assert (= has_empty_u (or (= f0_u "") (= f1_u "") (= f2_u ""))))

; Contradiction: require an empty field but also require all fields non-empty
(assert has_empty_u)
(assert (> (str.len f0_u) 0))
(assert (> (str.len f1_u) 0))
(assert (> (str.len f2_u) 0))

; ---------- Another SAT instance: 2-field CSV with no empty fields, plus simple content rules ----------
(declare-const csv_line_sat2 String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const rest1 String)

(assert (= (num_splits csv_line_sat2 delim) 2))
(assert (= g0 (split_at csv_line_sat2 delim 0)))
(assert (= g1 (split_at csv_line_sat2 delim 1)))
(assert (= rest1 (split_rest csv_line_sat2 delim 1)))

; No empty fields
(assert (> (str.len g0) 0))
(assert (> (str.len g1) 0))

; Some simple content constraints
(assert (str.contains g0 "id"))
(assert (not (str.contains g1 ",")))
(assert (= rest1 g1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
