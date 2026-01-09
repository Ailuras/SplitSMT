(set-logic ALL)

; Uninterpreted interface for string split methodology
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
; Scenario: CSV Processing
; =====================

; -------- SAT instance: a well-formed CSV line with exactly 4 fields, no empty fields --------
(declare-const csv_line_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= csv_line_ok "alpha,beta,gamma,delta"))
(assert (= (num_splits csv_line_ok ",") 4))
(assert (= f0_ok (split_at csv_line_ok "," 0)))
(assert (= f1_ok (split_at csv_line_ok "," 1)))
(assert (= f2_ok (split_at csv_line_ok "," 2)))
(assert (= f3_ok (split_at csv_line_ok "," 3)))

; Detect and forbid empty fields
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Additional sanity: rest from 2 should contain a comma separating field2 and field3
(declare-const rest_from_2_ok String)
(assert (= rest_from_2_ok (split_rest csv_line_ok "," 2)))
(assert (str.contains rest_from_2_ok ","))

; -------- SAT instance: CSV line with an empty middle field (should be detectable) --------
(declare-const csv_line_has_empty String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)
(declare-const e3 String)

(assert (= csv_line_has_empty "a,,c,d"))
(assert (= (num_splits csv_line_has_empty ",") 4))
(assert (= e0 (split_at csv_line_has_empty "," 0)))
(assert (= e1 (split_at csv_line_has_empty "," 1)))
(assert (= e2 (split_at csv_line_has_empty "," 2)))
(assert (= e3 (split_at csv_line_has_empty "," 3)))

; Empty field detection: at least one field is empty (here, field1)
(assert (= e1 ""))
(assert (> (str.len e0) 0))
(assert (> (str.len e2) 0))
(assert (> (str.len e3) 0))

; -------- UNSAT instance: conflicting requirements on field count --------
(declare-const csv_line_bad_count String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= csv_line_bad_count "x,y,z"))
(assert (= (num_splits csv_line_bad_count ",") 3))
(assert (= b0 (split_at csv_line_bad_count "," 0)))
(assert (= b1 (split_at csv_line_bad_count "," 1)))
(assert (= b2 (split_at csv_line_bad_count "," 2)))

; Contradiction: demand 4 fields while also fixing the line to have 3 segments
(assert (= (num_splits csv_line_bad_count ",") 4))

; -------- UNSAT instance: claim an empty field where the concrete CSV has no empty fields --------
(declare-const csv_line_no_empty String)
(declare-const n0 String)
(declare-const n1 String)
(declare-const n2 String)

(assert (= csv_line_no_empty "p,q,r"))
(assert (= (num_splits csv_line_no_empty ",") 3))
(assert (= n0 (split_at csv_line_no_empty "," 0)))
(assert (= n1 (split_at csv_line_no_empty "," 1)))
(assert (= n2 (split_at csv_line_no_empty "," 2)))

; Contradiction: force an empty middle field even though "p,q,r" has no empty segment
(assert (= n1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
