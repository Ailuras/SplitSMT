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

; Uninterpreted interface for string split

; =====================
; SAT instance: CSV processing with empty-field detection
; =====================
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const total_fields Int)
(declare-const has_empty Bool)

(assert (= delim ","))

; At least 4 fields (3 commas) expected for the main SAT case
(assert (= total_fields (num_splits csv_line delim)))
(assert (= total_fields 4))

; Extract fields and suffixes
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))
(assert (= rest3 (split_rest csv_line delim 3)))

; Indices are natural and within the expected segment count
(assert (and (<= 0 0) (< 0 total_fields)))
(assert (and (<= 0 1) (< 1 total_fields)))
(assert (and (<= 0 2) (< 2 total_fields)))
(assert (and (<= 0 3) (< 3 total_fields)))

; Basic sanity: no newline characters in the line (simple CSV line)
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Detect empty fields (including consecutive commas or trailing comma)
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Ensure we actually have an empty field and also at least one non-empty field
(assert has_empty)
(assert (or (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 ""))))

; Additional constraints to resemble typical CSV cleaning rules
; - No field contains the delimiter itself (no quoting modeled here)
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))
(assert (not (str.contains field3 delim)))

; - A weak structural relation: the remaining suffix from k has length at least the length of segment k
(assert (>= (str.len rest1) (str.len field1)))
(assert (>= (str.len rest2) (str.len field2)))
(assert (>= (str.len rest3) (str.len field3)))

; =====================
; UNSAT instance: contradictory requirements on empty fields and counts
; =====================
(declare-const csv_line_bad String)
(declare-const bad_fields Int)
(declare-const bad0 String)
(declare-const bad1 String)
(declare-const bad2 String)
(declare-const bad3 String)
(declare-const bad4 String)
(declare-const bad_has_empty Bool)

(assert (= bad_fields (num_splits csv_line_bad delim)))

; Require exactly 5 fields
(assert (= bad_fields 5))

; Extract 5 fields
(assert (= bad0 (split_at csv_line_bad delim 0)))
(assert (= bad1 (split_at csv_line_bad delim 1)))
(assert (= bad2 (split_at csv_line_bad delim 2)))
(assert (= bad3 (split_at csv_line_bad delim 3)))
(assert (= bad4 (split_at csv_line_bad delim 4)))

; Define emptiness predicate, then force contradiction: both has_empty and all fields non-empty
(assert (= bad_has_empty (or (= bad0 "") (= bad1 "") (= bad2 "") (= bad3 "") (= bad4 ""))))
(assert bad_has_empty)
(assert (not (= bad0 "")))
(assert (not (= bad1 "")))
(assert (not (= bad2 "")))
(assert (not (= bad3 "")))
(assert (not (= bad4 "")))

; Also add a conflicting count condition to strengthen UNSAT
(assert (>= (num_splits csv_line_bad delim) 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
