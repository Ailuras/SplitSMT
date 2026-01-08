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

; Uninterpreted interface for string split operations

; Scenario: CSV Processing (comma-separated fields)
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest_from_2 String)
(declare-const rest_from_4 String)
(declare-const empty_exists Bool)

; Delimiter is a comma
(assert (= delim ","))

; Basic split constraints
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= rest_from_2 (split_rest csv_line delim 2)))
(assert (= rest_from_4 (split_rest csv_line delim 4)))

; Index constraints (natural indices)
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0) (>= 4 0)))

; Non-empty line overall
(assert (> (str.len csv_line) 0))

; Require at least 4 fields (i.e., 4 segments)
(assert (>= (num_splits csv_line delim) 4))

; Detect presence of an empty field among the first four
(assert (= empty_exists (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; SAT part: enforce a concrete well-formed CSV with an empty middle field
; Example: "A,,C,D" => field0="A", field1="", field2="C", field3="D"
(assert (= csv_line (str.++ field0 "," field1 "," field2 "," field3)))
(assert (= field0 "A"))
(assert (= field2 "C"))
(assert (= field3 "D"))
(assert (= field1 ""))
(assert empty_exists)

; Additional sanity: if there are exactly 4 fields, rest_from_4 should be empty
(assert (=> (= (num_splits csv_line delim) 4) (= rest_from_4 "")))

; UNSAT instance (separate, intentionally contradictory) encoded via a flag
(declare-const make_unsat Bool)

; When make_unsat is true, demand exactly 4 fields and simultaneously require a comma inside field2.
; This conflicts with typical split semantics where fields cannot contain the delimiter.
; Since split_* are uninterpreted, we also add a consistency axiom tying split_at to split_rest for k=2.
(declare-const axiom_ok Bool)
(assert (= axiom_ok true))

; Consistency axiom (lightweight): if there are at least 3 splits, rest_from_2 starts with field2
(assert (=> (and axiom_ok (>= (num_splits csv_line delim) 3))
            (= rest_from_2 (str.++ field2 (str.++ delim (split_rest csv_line delim 3))))))

; Turn on UNSAT mode and assert contradiction under a strong delimiter-exclusion rule for field2
(assert make_unsat)
(assert (= (num_splits csv_line delim) 4))
(assert (str.contains field2 ","))
(assert (not (str.contains field2 delim)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
