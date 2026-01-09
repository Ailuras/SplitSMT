(set-logic ALL)

; Uninterpreted functions for str_split interface
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
; SAT instance: CSV line with exactly 4 fields, no empty fields
; =========================
(declare-const csv_line_ok String)
(declare-const delim String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= delim ","))

; Must have exactly 4 fields
(assert (= (num_splits csv_line_ok delim) 4))

; Extract fields
(assert (= f0_ok (split_at csv_line_ok delim 0)))
(assert (= f1_ok (split_at csv_line_ok delim 1)))
(assert (= f2_ok (split_at csv_line_ok delim 2)))
(assert (= f3_ok (split_at csv_line_ok delim 3)))

; Indices are natural and within bounds (for the intended interface discipline)
(assert (and (>= 0 0) (< 0 (num_splits csv_line_ok delim))))
(assert (and (>= 1 0) (< 1 (num_splits csv_line_ok delim))))
(assert (and (>= 2 0) (< 2 (num_splits csv_line_ok delim))))
(assert (and (>= 3 0) (< 3 (num_splits csv_line_ok delim))))

; Detect and forbid empty fields
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Additional typical CSV sanity: line contains at least 3 delimiters
(assert (str.contains csv_line_ok delim))
(assert (str.contains (split_rest csv_line_ok delim 1) delim))
(assert (str.contains (split_rest csv_line_ok delim 2) delim))

; Example-oriented content constraints to keep it nontrivial
(assert (str.in_re f0_ok (re.+ (str.to_re "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"))))
(assert (str.in_re f1_ok (re.+ (re.union (str.to_re "0123456789") (str.to_re "-")))))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; =========================
; UNSAT instance: exactly 3 fields but middle field is forced both empty and non-empty
; =========================
(declare-const csv_line_bad String)
(declare-const g0 String)
(declare-const g1 String)
(declare-const g2 String)

(assert (= (num_splits csv_line_bad delim) 3))
(assert (= g0 (split_at csv_line_bad delim 0)))
(assert (= g1 (split_at csv_line_bad delim 1)))
(assert (= g2 (split_at csv_line_bad delim 2)))

; Force empty middle field
(assert (= g1 ""))

; Simultaneously require all fields to be non-empty (contradiction)
(assert (> (str.len g0) 0))
(assert (> (str.len g1) 0))
(assert (> (str.len g2) 0))

; Another CSV check: with 3 fields, splitting rest from 2 should be the last field (sanity-style)
(assert (= (split_rest csv_line_bad delim 2) g2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
