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

; =====================
; SAT instance: CSV line with empty fields allowed, ensure field count and positions
; =====================
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const sat_fields Int)
(declare-const sat_f0 String)
(declare-const sat_f1 String)
(declare-const sat_f2 String)
(declare-const sat_f3 String)
(declare-const sat_tail_from2 String)

(assert (= delim ","))
(assert (= csv_line_sat "alice,,42,NY"))

; Expect exactly 4 fields (including empty field between consecutive commas)
(assert (= sat_fields (num_splits csv_line_sat delim)))
(assert (= sat_fields 4))

(assert (= sat_f0 (split_at csv_line_sat delim 0)))
(assert (= sat_f1 (split_at csv_line_sat delim 1)))
(assert (= sat_f2 (split_at csv_line_sat delim 2)))
(assert (= sat_f3 (split_at csv_line_sat delim 3)))

; Field content checks: detect empty second field
(assert (= sat_f0 "alice"))
(assert (= sat_f1 ""))
(assert (= sat_f2 "42"))
(assert (= sat_f3 "NY"))

; Additional structural check via split_rest
(assert (= sat_tail_from2 (split_rest csv_line_sat delim 2)))
(assert (= sat_tail_from2 "42,NY"))

; Basic index/domain constraints for split operations
(assert (>= sat_fields 1))

(check-sat)

; =====================
; UNSAT instance: claim a line has 3 fields but enforce it has an empty 4th field
; =====================
(declare-const csv_line_unsat String)
(declare-const uns_fields Int)
(declare-const uns_f0 String)
(declare-const uns_f1 String)
(declare-const uns_f2 String)
(declare-const uns_f3 String)

(assert (= csv_line_unsat "a,b,c,"))

; Contradictory expectations: require 3 splits but also require a 4th empty field exists
(assert (= uns_fields (num_splits csv_line_unsat delim)))
(assert (= uns_fields 3))

(assert (= uns_f0 (split_at csv_line_unsat delim 0)))
(assert (= uns_f1 (split_at csv_line_unsat delim 1)))
(assert (= uns_f2 (split_at csv_line_unsat delim 2)))
(assert (= uns_f3 (split_at csv_line_unsat delim 3)))

(assert (= uns_f0 "a"))
(assert (= uns_f1 "b"))
(assert (= uns_f2 "c"))
(assert (= uns_f3 ""))

; Interface-style bounds (natural indices); uns_f3 implies at least 4 fields
(assert (>= (num_splits csv_line_unsat delim) 4))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
