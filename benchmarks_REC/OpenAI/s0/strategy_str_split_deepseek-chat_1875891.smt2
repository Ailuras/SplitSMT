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

; --- Uninterpreted interface: str_split ---

; --- Scenario: CSV Processing ---
; We model a CSV line split by "," and constrain field counts and empties.

; ===== SAT instance: 4 fields, with an intentionally empty field =====
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest2_sat String)

(assert (= delim ","))

; Exactly 4 segments/fields
(assert (= (num_splits csv_line_sat delim) 4))

; Bind each field via split_at
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Index bounds (natural and within [0, num_splits-1])
(assert (and (<= 0 0) (< 0 (num_splits csv_line_sat delim))))
(assert (and (<= 0 1) (< 1 (num_splits csv_line_sat delim))))
(assert (and (<= 0 2) (< 2 (num_splits csv_line_sat delim))))
(assert (and (<= 0 3) (< 3 (num_splits csv_line_sat delim))))

; Detect an empty field (e.g., consecutive commas create empty string)
(assert (= f2_sat ""))

; No newline characters inside fields (simple sanitation)
(assert (not (str.contains f0_sat "\n")))
(assert (not (str.contains f1_sat "\n")))
(assert (not (str.contains f2_sat "\n")))
(assert (not (str.contains f3_sat "\n")))

; Rest-of-line from index 2 is concatenation of f2,f3 with delimiter between (relaxed via split_rest)
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))
(assert (>= (str.len rest2_sat) (str.len f2_sat)))

; Additional plausibility constraints
(assert (>= (str.len f0_sat) 1))
(assert (>= (str.len f1_sat) 1))
(assert (>= (str.len f3_sat) 1))

; ===== UNSAT instance: contradictions about empty detection and field count =====
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)

; Claim there are exactly 3 fields
(assert (= (num_splits csv_line_unsat delim) 3))

; Bind fields
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))

; Index bounds for 0..2
(assert (and (<= 0 0) (< 0 (num_splits csv_line_unsat delim))))
(assert (and (<= 0 1) (< 1 (num_splits csv_line_unsat delim))))
(assert (and (<= 0 2) (< 2 (num_splits csv_line_unsat delim))))

; Contradiction: field is both empty and non-empty
(assert (= g1_unsat ""))
(assert (>= (str.len g1_unsat) 1))

; Another contradiction: require at least 4 fields
(assert (>= (num_splits csv_line_unsat delim) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
