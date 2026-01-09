(set-logic ALL)

; Uninterpreted functions for string split interface
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

; =========================
; Scenario: CSV Processing
; =========================

; ---- SAT instance: well-formed CSV line with 4 fields and non-empty critical fields ----
(declare-const csv_line_ok String)
(declare-const delim String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)
(declare-const rest_from_2_ok String)
(declare-const idx_comma_ok Int)

(assert (= delim ","))

; Field count constraints
(assert (= (num_splits csv_line_ok delim) 4))

; Extract fields
(assert (= f0_ok (split_at csv_line_ok delim 0)))
(assert (= f1_ok (split_at csv_line_ok delim 1)))
(assert (= f2_ok (split_at csv_line_ok delim 2)))
(assert (= f3_ok (split_at csv_line_ok delim 3)))

; Non-empty constraints for required fields (e.g., ID, name)
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))

; Allow an optional empty field in position 2, but require last field non-empty
(assert (>= (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; Rest concatenation from field 2 must equal a known pattern for 2 trailing fields
(assert (= rest_from_2_ok (split_rest csv_line_ok delim 2)))
(assert (= rest_from_2_ok (str.++ f2_ok delim f3_ok)))

; Additional sanity: if there are 4 splits, index access for 0..3 is valid (natural indices)
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Ensure there is at least one comma in the overall line using indexof
(assert (= idx_comma_ok (str.indexof csv_line_ok delim 0)))
(assert (>= idx_comma_ok 0))

; Constrain the line to look like 3 commas separating 4 fields
(assert (= csv_line_ok (str.++ f0_ok delim f1_ok delim f2_ok delim f3_ok)))

; ---- UNSAT instance: detect contradictory requirements around empty fields and field count ----
(declare-const csv_line_bad String)
(declare-const g0_bad String)
(declare-const g1_bad String)
(declare-const g2_bad String)
(declare-const g3_bad String)
(declare-const rest_from_1_bad String)
(declare-const idx_comma_bad Int)

; Enforce exactly 4 fields
(assert (= (num_splits csv_line_bad delim) 4))

; Extract fields
(assert (= g0_bad (split_at csv_line_bad delim 0)))
(assert (= g1_bad (split_at csv_line_bad delim 1)))
(assert (= g2_bad (split_at csv_line_bad delim 2)))
(assert (= g3_bad (split_at csv_line_bad delim 3)))

; Build-up constraint for CSV structure
(assert (= csv_line_bad (str.++ g0_bad delim g1_bad delim g2_bad delim g3_bad)))

; Empty field detection: require second field empty
(assert (= g1_bad ""))

; Contradiction: also require all fields non-empty
(assert (> (str.len g0_bad) 0))
(assert (> (str.len g1_bad) 0))
(assert (> (str.len g2_bad) 0))
(assert (> (str.len g3_bad) 0))

; Additional rest constraint that is consistent with concatenation, but still UNSAT due to empty/non-empty conflict
(assert (= rest_from_1_bad (split_rest csv_line_bad delim 1)))
(assert (= rest_from_1_bad (str.++ g1_bad delim g2_bad delim g3_bad)))

; Ensure comma exists (not the source of UNSAT)
(assert (= idx_comma_bad (str.indexof csv_line_bad delim 0)))
(assert (>= idx_comma_bad 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
