(set-logic ALL)

; Uninterpreted interface operations for str_split
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

; ---------
; SAT case: a 4-field CSV row, with an empty field in the middle
; ---------
(declare-const csv_row_sat String)
(declare-const delim String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail1 String)
(declare-const sat_tail2 String)
(declare-const sat_idx Int)

(assert (= delim ","))

; Enforce total field count = 4
(assert (= (num_splits csv_row_sat delim) 4))

; Extract fields by index
(assert (= sat_f0 (split_at csv_row_sat delim 0)))
(assert (= sat_f1 (split_at csv_row_sat delim 1)))
(assert (= sat_f2 (split_at csv_row_sat delim 2)))
(assert (= sat_f3 (split_at csv_row_sat delim 3)))

; Indices are natural and within range
(assert (>= sat_idx 0))
(assert (< sat_idx (num_splits csv_row_sat delim)))

; Remainders/tails after splitting
(assert (= sat_tail1 (split_rest csv_row_sat delim 1)))
(assert (= sat_tail2 (split_rest csv_row_sat delim 2)))

; Detect an empty field: field 2 is empty
(assert (= sat_f2 ""))

; Non-empty constraints for other fields (typical CSV sanity)
(assert (> (str.len sat_f0) 0))
(assert (> (str.len sat_f1) 0))
(assert (> (str.len sat_f3) 0))

; Fields should not themselves contain the delimiter
(assert (not (str.contains sat_f0 delim)))
(assert (not (str.contains sat_f1 delim)))
(assert (not (str.contains sat_f2 delim)))
(assert (not (str.contains sat_f3 delim)))

; Constrain the row to a simple concrete shape: A,B,,D
(assert (= csv_row_sat (str.++ sat_f0 delim sat_f1 delim sat_f2 delim sat_f3)))

; Give concrete candidates (still SAT)
(assert (= sat_f0 "A"))
(assert (= sat_f1 "B"))
(assert (= sat_f3 "D"))

; Some additional consistency constraints involving tails
(assert (= sat_tail1 (str.++ sat_f1 delim sat_f2 delim sat_f3)))
(assert (= sat_tail2 (str.++ sat_f2 delim sat_f3)))


; ---------
; UNSAT case: contradictions about empty-field detection and field count
; ---------
(declare-const csv_row_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)
(declare-const uns_f3 String)
(declare-const uns_f4 String)
(declare-const uns_bad_empty String)
(declare-const uns_k Int)

; Force 5 fields
(assert (= (num_splits csv_row_unsat delim) 5))

; Extract fields 0..4
(assert (= uns_f0 (split_at csv_row_unsat delim 0)))
(assert (= uns_f1 (split_at csv_row_unsat delim 1)))
(assert (= uns_f2 (split_at csv_row_unsat delim 2)))
(assert (= uns_f3 (split_at csv_row_unsat delim 3)))
(assert (= uns_f4 (split_at csv_row_unsat delim 4)))

; Constrain row as a 5-field CSV
(assert (= csv_row_unsat (str.++ uns_f0 delim uns_f1 delim uns_f2 delim uns_f3 delim uns_f4)))

; Natural index constraint
(assert (>= uns_k 0))
(assert (< uns_k (num_splits csv_row_unsat delim)))

; Model "detect empty" using a selected field (uns_bad_empty), but contradict it
; First, require field 3 is empty
(assert (= uns_f3 ""))
; Then define the detected-empty field to be field 3
(assert (= uns_bad_empty uns_f3))
; Contradiction: detected-empty must be non-empty
(assert (> (str.len uns_bad_empty) 0))

; Additional contradiction about count: also assert it is 4
(assert (= (num_splits csv_row_unsat delim) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
