(set-logic ALL)
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

; Uninterpreted interface for string splitting

; ========== SAT instance: CSV processing with correct field counts and empty-field detection ==========
(declare-const csv_line_sat String)
(declare-const delim String)
(declare-const f0_sat String)
(declare-const f1_sat String)
(declare-const f2_sat String)
(declare-const f3_sat String)
(declare-const rest1_sat String)
(declare-const rest2_sat String)
(declare-const empty_count_sat Int)
(declare-const is_empty1_sat Bool)

(assert (= delim ","))

; Enforce exactly 4 fields
(assert (= (num_splits csv_line_sat delim) 4))

; Extract fields
(assert (= f0_sat (split_at csv_line_sat delim 0)))
(assert (= f1_sat (split_at csv_line_sat delim 1)))
(assert (= f2_sat (split_at csv_line_sat delim 2)))
(assert (= f3_sat (split_at csv_line_sat delim 3)))

; Remainder views
(assert (= rest1_sat (split_rest csv_line_sat delim 1)))
(assert (= rest2_sat (split_rest csv_line_sat delim 2)))

; Make a concrete CSV line via concatenation to witness SAT
; Example: "id,,42,OK" (second field is empty)
(assert (= csv_line_sat (str.++ "id" "," "" "," "42" "," "OK")))

; Detect an empty field (field 1) and ensure others are non-empty
(assert (= is_empty1_sat (= f1_sat "")))
(assert is_empty1_sat)
(assert (not (= f0_sat "")))
(assert (not (= f2_sat "")))
(assert (not (= f3_sat "")))

; Count empty fields among f0..f3 (here exactly 1)
(assert (= empty_count_sat
  (+ (ite (= f0_sat "") 1 0)
     (ite (= f1_sat "") 1 0)
     (ite (= f2_sat "") 1 0)
     (ite (= f3_sat "") 1 0))))
(assert (= empty_count_sat 1))

; Sanity: no delimiter inside fields (simple CSV assumption)
(assert (not (str.contains f0_sat delim)))
(assert (not (str.contains f1_sat delim)))
(assert (not (str.contains f2_sat delim)))
(assert (not (str.contains f3_sat delim)))

; Additional constraint: third field is numeric-like (only digits, non-empty)
(assert (> (str.len f2_sat) 0))
(assert (str.in_re f2_sat (re.+ (re.range "0" "9"))))

; Keep segment indices natural
(assert (and (>= 0 0) (>= 1 0) (>= 2 0) (>= 3 0)))

(check-sat)

; ========== UNSAT instance: contradictory requirements on empty fields / field count ==========
(declare-const csv_line_unsat String)
(declare-const g0_unsat String)
(declare-const g1_unsat String)
(declare-const g2_unsat String)
(declare-const g3_unsat String)
(declare-const empty_count_unsat Int)

; Require exactly 4 fields
(assert (= (num_splits csv_line_unsat delim) 4))

; Extract fields
(assert (= g0_unsat (split_at csv_line_unsat delim 0)))
(assert (= g1_unsat (split_at csv_line_unsat delim 1)))
(assert (= g2_unsat (split_at csv_line_unsat delim 2)))
(assert (= g3_unsat (split_at csv_line_unsat delim 3)))

; Define empty count
(assert (= empty_count_unsat
  (+ (ite (= g0_unsat "") 1 0)
     (ite (= g1_unsat "") 1 0)
     (ite (= g2_unsat "") 1 0)
     (ite (= g3_unsat "") 1 0))))

; Contradiction: all fields non-empty but empty_count = 2
(assert (not (= g0_unsat "")))
(assert (not (= g1_unsat "")))
(assert (not (= g2_unsat "")))
(assert (not (= g3_unsat "")))
(assert (= empty_count_unsat 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
