(set-logic ALL)

; Uninterpreted interface operations for str_split
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

; -------------------------------
; Scenario: CSV Processing
; Goal: process comma-separated data fields to ensure correct field counts and detect empty fields.
; This file contains both SAT and UNSAT instances.
; -------------------------------

; -------- SAT instance --------
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const n_sat Int)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)
(declare-const rest3_sat String)
(declare-const has_empty_sat Bool)

(assert (= delim ","))

; Extract first 4 fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Remainders from index k onwards
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))
(assert (= rest3_sat (split_rest csv_line_sat delim 3)))

; Field count constraints: exactly 4 segments
(assert (= n_sat (num_splits csv_line_sat delim)))
(assert (= n_sat 4))

; Indices natural (interface discipline)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Content constraints: two numeric fields, one empty field, and a final token "END"
(assert (str.in_re f0_sat (re.+ (re.range "0" "9"))))
(assert (= f1_sat ""))
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))
(assert (= f3_sat "END"))

; Detect empty fields (at least one empty)
(assert (= has_empty_sat (or (= f0_sat "") (= f1_sat "") (= f2_sat "") (= f3_sat ""))))
(assert has_empty_sat)

; Ensure the original line contains at least one comma (implied by 4 splits, but explicit)
(assert (str.contains csv_line_sat ","))

; Additional consistency: if rest2 begins with f2, then it contains f2
(assert (str.contains rest2_sat f2_sat))
(assert (str.contains rest3_sat f3_sat))

; Optional pattern: line has digits, then two commas in a row somewhere due to empty field
(assert (str.contains csv_line_sat ",,"))

; -------- UNSAT instance --------
(declare-const csv_line_unsat String)
(declare-const n_unsat Int)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)
(declare-const g3 String)
(declare-const all_nonempty Bool)
(declare-const some_empty Bool)

(assert (= g0 (split_at csv_line_unsat delim 0)))
(assert (= g1 (split_at csv_line_unsat delim 1)))
(assert (= g2 (split_at csv_line_unsat delim 2)))
(assert (= g3 (split_at csv_line_unsat delim 3)))

(assert (= n_unsat (num_splits csv_line_unsat delim)))

; Claim there are exactly 3 segments...
(assert (= n_unsat 3))
; ...but also assert a 4th segment exists and is non-empty, conflicting with the intended meaning
(assert (not (= g3 "")))

; Enforce all fields non-empty
(assert (= all_nonempty (and (not (= g0 "")) (not (= g1 "")) (not (= g2 "")) (not (= g3 "")))))
(assert all_nonempty)

; Simultaneously assert some field is empty -> contradiction
(assert (= some_empty (or (= g0 "") (= g1 "") (= g2 "") (= g3 ""))))
(assert some_empty)

; Extra CSV-like constraint: if exactly 3 segments, line must have at least 2 commas
(assert (=> (= n_unsat 3) (str.contains csv_line_unsat ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
