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

; ========== SAT instance: well-formed CSV line with possible empty fields ========== 
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_field4 String)
(declare-const sat_tail2 String)
(declare-const sat_tail3 String)
(declare-const sat_hasEmpty Bool)

(assert (= delim ","))

; Require 5 fields total => 5 segments after split
(assert (= (num_splits csv_line_sat delim) 5))

; Extract each field
(assert (= sat_field0 (split_at csv_line_sat delim 0)))
(assert (= sat_field1 (split_at csv_line_sat delim 1)))
(assert (= sat_field2 (split_at csv_line_sat delim 2)))
(assert (= sat_field3 (split_at csv_line_sat delim 3)))
(assert (= sat_field4 (split_at csv_line_sat delim 4)))

; Use split_rest to relate suffixes (structural sanity constraints)
(assert (= sat_tail2 (split_rest csv_line_sat delim 2)))
(assert (= sat_tail3 (split_rest csv_line_sat delim 3)))

; Constrain indices to be natural and within range implied by num_splits
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3) (<= 0 4)))

; A CSV processor usually expects no delimiter inside fields (simple approximation)
(assert (not (str.contains sat_field0 delim)))
(assert (not (str.contains sat_field1 delim)))
(assert (not (str.contains sat_field2 delim)))
(assert (not (str.contains sat_field3 delim)))
(assert (not (str.contains sat_field4 delim)))

; Detect empty fields: sat_hasEmpty is true iff any field is empty
(assert (= sat_hasEmpty (or (= sat_field0 "") (= sat_field1 "") (= sat_field2 "") (= sat_field3 "") (= sat_field4 ""))))

; Require at least one empty field to be detected
(assert sat_hasEmpty)

; Additional realistic constraints: header-like first field and numeric 4th field
(assert (str.in_re sat_field0 (re.++ (str.to_re "ID") (re.* (str.to_re "")))))
(assert (>= (str.len sat_field0) 2))

; Make one specific field empty and another non-empty
(assert (= sat_field2 ""))
(assert (> (str.len sat_field1) 0))
(assert (> (str.len sat_field4) 0))

; Shape tails: tail from 3 contains field3,",",field4 (approx via contains)
(assert (str.contains sat_tail3 sat_field3))
(assert (str.contains sat_tail3 sat_field4))

; Make the whole line concrete enough to avoid degenerate models
(assert (= csv_line_sat (str.++ sat_field0 "," sat_field1 "," sat_field2 "," sat_field3 "," sat_field4)))

; ========== UNSAT instance: contradictory constraints on field count / emptiness ========== 
(declare-const csv_line_unsat String)
(declare-const unsat_field0 String)
(declare-const unsat_field1 String)
(declare-const unsat_field2 String)
(declare-const unsat_field3 String)
(declare-const unsat_hasEmpty Bool)

; Claim 4 fields, but also enforce a 5-field construction: contradiction via num_splits
(assert (= (num_splits csv_line_unsat delim) 4))

(assert (= unsat_field0 (split_at csv_line_unsat delim 0)))
(assert (= unsat_field1 (split_at csv_line_unsat delim 1)))
(assert (= unsat_field2 (split_at csv_line_unsat delim 2)))
(assert (= unsat_field3 (split_at csv_line_unsat delim 3)))

; Define emptiness detector
(assert (= unsat_hasEmpty (or (= unsat_field0 "") (= unsat_field1 "") (= unsat_field2 "") (= unsat_field3 ""))))

; Require no empty fields
(assert (not unsat_hasEmpty))

; Yet force a specific field to be empty: contradiction
(assert (= unsat_field1 ""))

; Additionally, construct a 5-field CSV string explicitly, which should imply 5 splits
(declare-const unsat_extra_field4 String)
(assert (> (str.len unsat_extra_field4) 0))
(assert (= csv_line_unsat (str.++ unsat_field0 "," unsat_field1 "," unsat_field2 "," unsat_field3 "," unsat_extra_field4)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
