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

; Uninterpreted functions for string split interface

; =====================
; SAT instance: well-formed CSV row with possible empty fields
; =====================
(declare-const csv_row String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const field4 String)
(declare-const rest2 String)
(declare-const has_empty_field Bool)

(assert (= delim ","))

; Require exactly 5 fields (i.e., 5 segments when splitting by comma)
(assert (= (num_splits csv_row delim) 5))

; Extract fields
(assert (= field0 (split_at csv_row delim 0)))
(assert (= field1 (split_at csv_row delim 1)))
(assert (= field2 (split_at csv_row delim 2)))
(assert (= field3 (split_at csv_row delim 3)))
(assert (= field4 (split_at csv_row delim 4)))

; Rest of row from field 2 onward (sanity link)
(assert (= rest2 (split_rest csv_row delim 2)))

; Field constraints: non-empty header and last field, middle may be empty
(assert (> (str.len field0) 0))
(assert (> (str.len field4) 0))
(assert (>= (str.len field1) 0))
(assert (>= (str.len field2) 0))
(assert (>= (str.len field3) 0))

; Detect empty fields
(assert (= has_empty_field (or (= field1 "") (= field2 "") (= field3 ""))))

; Ensure there is at least one empty field to test detection logic
(assert has_empty_field)

; Additional lightweight content checks
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field4 ",")))
(assert (not (str.contains rest2 ",,")))

(check-sat)

; =====================
; UNSAT instance: contradictory constraints about empty fields and composition
; =====================
(declare-const csv_row_u String)
(declare-const f0_u String)
(declare-const f1_u String)
(declare-const f2_u String)
(declare-const f3_u String)
(declare-const f4_u String)
(declare-const has_empty_u Bool)
(declare-const reconstructed_u String)

(assert (= (num_splits csv_row_u ",") 5))
(assert (= f0_u (split_at csv_row_u "," 0)))
(assert (= f1_u (split_at csv_row_u "," 1)))
(assert (= f2_u (split_at csv_row_u "," 2)))
(assert (= f3_u (split_at csv_row_u "," 3)))
(assert (= f4_u (split_at csv_row_u "," 4)))

; Define emptiness detector and contradict it
(assert (= has_empty_u (or (= f0_u "") (= f1_u "") (= f2_u "") (= f3_u "") (= f4_u ""))))
(assert has_empty_u)
(assert (and (> (str.len f0_u) 0) (> (str.len f1_u) 0) (> (str.len f2_u) 0) (> (str.len f3_u) 0) (> (str.len f4_u) 0)))

; Reconstruction with explicit commas
(assert (= reconstructed_u (str.++ f0_u "," f1_u "," f2_u "," f3_u "," f4_u)))

; Force a shape that cannot have 5 segments: no commas at all
(assert (not (str.contains reconstructed_u ",")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
