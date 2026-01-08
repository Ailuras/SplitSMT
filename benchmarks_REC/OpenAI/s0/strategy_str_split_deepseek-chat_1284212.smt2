(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

; Uninterpreted interface for string split operations

; Scenario: CSV Processing (comma-separated fields)
; We model parsing a CSV line, enforce field counts, and detect empty fields.

; --------------------
; SAT instance: well-formed CSV with 4 fields, some constraints on content
; --------------------
(declare-const csv_line_sat String)
(declare-const delim_comma String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)

(assert (= delim_comma ","))

; field extraction
(assert (= f0_sat (split_at csv_line_sat delim_comma 0)))
(assert (= f1_sat (split_at csv_line_sat delim_comma 1)))
(assert (= f2_sat (split_at csv_line_sat delim_comma 2)))
(assert (= f3_sat (split_at csv_line_sat delim_comma 3)))

; rest reconstruction checks
(assert (= rest1_sat (split_rest csv_line_sat delim_comma 1)))
(assert (= rest2_sat (split_rest csv_line_sat delim_comma 2)))
(assert (= rest3_sat (split_rest csv_line_sat delim_comma 3)))
(assert (= rest1_sat (str.++ f1_sat delim_comma rest2_sat)))
(assert (= rest2_sat (str.++ f2_sat delim_comma rest3_sat)))

; exactly 4 fields (segments)
(assert (= (num_splits csv_line_sat delim_comma) 4))

; CSV should have at least 3 commas if it has 4 fields
(assert (>= (str.len csv_line_sat) 3))

; detect empty fields: enforce one empty field at index 2
(assert (= f2_sat ""))

; other fields non-empty
(assert (> (str.len f0_sat) 0))
(assert (> (str.len f1_sat) 0))
(assert (> (str.len f3_sat) 0))

; additional sanity: no commas inside fields (approximation via contains)
(assert (not (str.contains f0_sat delim_comma)))
(assert (not (str.contains f1_sat delim_comma)))
(assert (not (str.contains f2_sat delim_comma)))
(assert (not (str.contains f3_sat delim_comma)))

; constrain some content patterns using basic properties
(assert (= (str.at f0_sat 0) "A"))
(assert (= (str.at f3_sat 0) "Z"))

; indices are natural where used
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

(check-sat)

; --------------------
; UNSAT instance: conflicting requirements about field counts and emptiness
; --------------------
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

(assert (= g0_unsat (split_at csv_line_unsat delim_comma 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim_comma 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim_comma 2)))

; claim it has 3 fields
(assert (= (num_splits csv_line_unsat delim_comma) 3))

; also (incorrectly) require a 4th field to exist and be non-empty
(declare-const g3_unsat String)
(assert (= g3_unsat (split_at csv_line_unsat delim_comma 3)))
(assert (> (str.len g3_unsat) 0))

; but force the remainder from index 3 to be empty (i.e., no field content)
(declare-const rest3_unsat String)
(assert (= rest3_unsat (split_rest csv_line_unsat delim_comma 3)))
(assert (= rest3_unsat ""))

; additionally, require the 2nd field to be empty and non-empty simultaneously
(assert (= g1_unsat ""))
(assert (> (str.len g1_unsat) 0))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
