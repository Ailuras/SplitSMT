(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; Scenario: CSV Processing
; We model a CSV line split by "," and add constraints to enforce field counts and detect empty fields.

; ----------------------------
; SAT instance: well-formed CSV with at least 4 fields and a detected empty field
; ----------------------------
(declare-const csv_line_sat String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail_from2 String)

(assert (= sat_f0 (split_at csv_line_sat "," 0)))
(assert (= sat_f1 (split_at csv_line_sat "," 1)))
(assert (= sat_f2 (split_at csv_line_sat "," 2)))
(assert (= sat_f3 (split_at csv_line_sat "," 3)))
(assert (= sat_tail_from2 (split_rest csv_line_sat "," 2)))

; Require at least 4 segments/fields
(assert (>= (num_splits csv_line_sat ",") 4))

; Detect an empty field: field 1 is empty
(assert (= sat_f1 ""))

; Basic sanity constraints to keep indices natural and within plausible bounds
(assert (>= (num_splits csv_line_sat ",") 1))

; Add content constraints: first field is an ID-like number, third field contains a dash
(assert (str.in_re sat_f0 (re.+ (re.range "0" "9"))))
(assert (str.contains sat_f2 "-"))

; Also relate tail: tail_from2 must include field2 and field3 separated by comma when there are exactly 4 fields
; We do not force exactness, but if exactly 4 splits, then tail_from2 is f2,f3
(assert (=> (= (num_splits csv_line_sat ",") 4)
            (= sat_tail_from2 (str.++ sat_f2 "," sat_f3))))

; Avoid trivial empty whole line
(assert (>= (str.len csv_line_sat) 1))

; ----------------------------
; UNSAT instance: contradictory constraints about emptiness and numeric-only field
; ----------------------------
(declare-const csv_line_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)

(assert (= uns_f0 (split_at csv_line_unsat "," 0)))
(assert (= uns_f1 (split_at csv_line_unsat "," 1)))
(assert (= uns_f2 (split_at csv_line_unsat "," 2)))

; Require exactly 3 fields
(assert (= (num_splits csv_line_unsat ",") 3))

; State that field0 is numeric-only and non-empty
(assert (str.in_re uns_f0 (re.+ (re.range "0" "9"))))

; Contradiction: also state field0 is empty
(assert (= uns_f0 ""))

; Additional constraints about empty field detection (irrelevant to core contradiction but CSV-related)
(assert (or (= uns_f1 "") (= uns_f2 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
