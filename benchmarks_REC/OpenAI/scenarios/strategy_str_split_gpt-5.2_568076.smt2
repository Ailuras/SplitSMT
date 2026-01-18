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

; Uninterpreted interface for string splitting

; -----------------------------
; SAT instance: well-formed CSV row with a fixed field count and some content rules
; -----------------------------
(declare-const csv_row String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_from2 String)

(assert (= delim ","))

; Exactly 4 fields (i.e., 4 segments after splitting by comma)
(assert (= (num_splits csv_row delim) 4))

; Bind fields by index
(assert (= field0 (split_at csv_row delim 0)))
(assert (= field1 (split_at csv_row delim 1)))
(assert (= field2 (split_at csv_row delim 2)))
(assert (= field3 (split_at csv_row delim 3)))

; Bind rest from index 2 onwards
(assert (= rest_from2 (split_rest csv_row delim 2)))

; Construct a concrete row satisfying constraints
(assert (= csv_row "alice,42,,NY"))

; Detect empty field: field2 is empty due to consecutive commas
(assert (= field2 ""))

; Some content checks
(assert (not (= field0 "")))
(assert (not (str.contains field0 delim)))
(assert (not (= field1 "")))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field3 delim)))

; Relationship check involving rest
(assert (str.prefixof field2 rest_from2))
(assert (str.contains rest_from2 field3))


; -----------------------------
; UNSAT instance: contradicts empty-field detection on a concrete row
; -----------------------------
(declare-const csv_row_bad String)
(declare-const bad0 String)
(declare-const bad1 String)
(declare-const bad2 String)

(assert (= csv_row_bad "x,,z"))
(assert (= (num_splits csv_row_bad delim) 3))
(assert (= bad0 (split_at csv_row_bad delim 0)))
(assert (= bad1 (split_at csv_row_bad delim 1)))
(assert (= bad2 (split_at csv_row_bad delim 2)))

; In "x,,z", the middle field must be empty, so forcing it non-empty makes this UNSAT
(assert (not (= bad1 "")))

(check-sat)
(exit)
