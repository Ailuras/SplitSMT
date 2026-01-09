(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ========== SAT instance: well-formed CSV line with an empty field ==========
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail2 String)

(assert (= delim ","))

; Require exactly 4 fields (segments) after splitting by comma
(assert (= (num_splits csv_line_sat delim) 4))

; Bind fields via split_at
(assert (= sat_f0 (split_at csv_line_sat delim 0)))
(assert (= sat_f1 (split_at csv_line_sat delim 1)))
(assert (= sat_f2 (split_at csv_line_sat delim 2)))
(assert (= sat_f3 (split_at csv_line_sat delim 3)))

; Bind remainder from index 2 onwards
(assert (= sat_tail2 (split_rest csv_line_sat delim 2)))

; Detect/ensure an empty middle field (e.g., "alpha,,gamma,42")
(assert (= sat_f1 ""))

; Additional sanity: non-empty surrounding fields and a numeric last field
(assert (not (= sat_f0 "")))
(assert (not (= sat_f2 "")))
(assert (str.in_re sat_f3 (re.+ (re.range "0" "9"))))

; Ensure comma delimiter appears and there is at least one empty-field pattern ",,"
(assert (str.contains csv_line_sat delim))
(assert (str.contains csv_line_sat ",,"))

; Simple consistency between tail and known fields (tail must contain the later fields)
(assert (str.contains sat_tail2 sat_f2))
(assert (str.contains sat_tail2 sat_f3))


; ========== UNSAT instance: contradictory empty/non-empty requirements ==========
(declare-const csv_line_unsat String)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)

; Exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))
(assert (= uns_f0 (split_at csv_line_unsat delim 0)))
(assert (= uns_f1 (split_at csv_line_unsat delim 1)))
(assert (= uns_f2 (split_at csv_line_unsat delim 2)))

; Contradiction: the same field must be empty and non-empty
(assert (= uns_f1 ""))
(assert (not (= uns_f1 "")))


; ========== UNSAT instance: conflicting field count constraints ==========
(declare-const csv_line_unsat2 String)
(assert (= (num_splits csv_line_unsat2 delim) 2))
(assert (= (num_splits csv_line_unsat2 delim) 5))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
